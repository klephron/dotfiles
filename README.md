# dotfiles

The agony of automation and deduplication, multiple profiles included.

## Installation

Clone the repository:

```sh
git clone --recurse-submodules https://github.com/klephron/dotfiles.git
```

Apply configuration:

```sh
make install/<profile>
```

Run to see more usage details:

```sh
make help
```

## Profiles

Located at `profiles/`:

- `desktop` - primary, desktop environment (default)
- `cli-dev` - devcontainers

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
