# Yet Another Ren'Py Image

Image aimed to be used in Github actions for building [Ren'Py](https://www.renpy.org/) projects.

## Developing

```bash
docker build -t aristarhys/yari:latest -t aristarhys/yari:8.2.1 --squash=true .
docker push --all-tags aristarhys/yari
```

## Example action

```yaml
name: Build published release
on:
  release:
    types: [published]
jobs:
  Release:
    runs-on: ubuntu-latest
    container:
      image: aristarhys/yari:latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
        with:
          lfs: true

      - name: Build release
        working-directory: /renpy
        run: ./renpy.sh launcher distribute --package market --dest /release $GITHUB_WORKSPACE

      - name: Set release path output
        id: set_release_path
        working-directory: /release
        run: |
          FILE_NAME=$(ls -qt1 | head -n 1)
          FILE_PATH=$(realpath $FILE_NAME)
          echo "::set-output name=FILE_NAME::$FILE_NAME"
          echo "::set-output name=FILE_PATH::$FILE_PATH"

      - name: Upload release to action
        uses: actions/upload-artifact@v4
        with:
          name: ${{ steps.set_release_path.outputs.FILE_NAME }}
          path: ${{ steps.set_release_path.outputs.FILE_PATH }}

      - name: Upload release to published tag
        uses: svenstaro/upload-release-action@v2
        with:
          repo_token: ${{ secrets.GITHUB_TOKEN }}
          asset_name: ${{ steps.set_release_path.outputs.FILE_NAME }}
          file: ${{ steps.set_release_path.outputs.FILE_PATH }}
          tag: ${{ github.ref }}
```
