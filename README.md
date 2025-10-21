# dotfiles

The agony of automation and deduplication, multiple profiles included.

## Installation

Clone the repository:

```sh
git clone --recurse-submodules https://github.com/klephron/dotfiles.git
```

Run to set symlinks, environment variables in `~/.profile`, login shell:

```sh
bash -x ./scripts/bootstrap.sh <profile>
```

> If `<profile>` is omitted, `cli-dev` is used.

Run to only set symlinks:

```sh
make install/<profile>
```

Run to see more usage details:

```sh
make help
```

## Profiles

Located at `profiles/`:

- `desktop` - primary, for desktop environment
- `cli-dev` - for devcontainers

## Update

### To pinned submodule commits

```sh
git pull --recurse-submodules
```

### To latest submodule commits

Initialize or update all submodules (if not done yet):

```sh
git submodule update --init --recursive
```

```sh
git pull
git submodule update --remote
```
