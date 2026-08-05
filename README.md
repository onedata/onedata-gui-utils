# IDE configuration

This repo contains example configuration for IDEs in `/ide-configs/` directory

## Visual Studio Code

Invoked from project root dir, when `onedata-gui-utils` is placed in it:

```shell
cp -r onedata-gui-utils/ide-configs/vscode .vscode
```

# Central Development Script

**Prerequisites:** `tmux` (mulit-pane terminal) and `kubectl` (synchronizing files with
onenv) installed and configured.

There is a `scripts/dev.sh` script that can run few typical development scenarios using
short command. To simplify the development, you can create an alias in your shell
configuration file using `./onedata-gui-utils/scripts/install-dev-alias.sh`.

```shell
alias dev="./onedata-gui-utils/scripts/dev.sh"
```

assuming that `onedata-gui-utils` is placed in the root of your project as a submodule
(e.g. `onepanel-gui`).

Example usage:

```shell
dev onenv ~/Onedata/one-env-focal/src-dev
```

opens a splitted terminal window with two panes, one running `ember build` in watch mode
and the other running a script that copies the built GUI to the backend pod in watch mode.

Alternatively, you can set the `BACKEND_SRC_ROOT` environment variable to the path of your
backend source root (e.g., in your shell configuration), and then run:

```shell
export BACKEND_SRC_ROOT=~/Onedata/one-env-focal/src-dev
dev onenv
```

Refer to the `scripts/dev.sh` script for more details and available commands.
