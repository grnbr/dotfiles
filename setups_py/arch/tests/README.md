# Docker testing

## Build the image

Rebuild only when the `Dockerfile` changes.

```bash
docker build --network=host -t dotfiles-test \
-f setups_py/arch/tests/Dockerfile .
```

## Saving state

Keeps installed packages and files between runs.

### Create (once)

Run from the repo root, because `$PWD` is mounted at `/dotfiles`.

```bash
docker run -it --name dotfiles --network=host \
-v "$PWD":/dotfiles dotfiles-test bash
```

### Start again

```bash
docker start -ai dotfiles
```

## Clean state

Deleted on exit (`--rm`), so every run starts fresh.

```bash
docker run --rm -it --network=host -v "$PWD":/dotfiles dotfiles-test bash
```
