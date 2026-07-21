# IDE configuration

This repo contains example configuration for IDEs in `/ide-configs/` directory

## Visual Studio Code

Invoked from project root dir, when `onedata-gui-utils` is placed in it:

```shell
cp -r onedata-gui-utils/ide-configs/vscode .vscode
```

# Central Development Script

There is a `scripts/dev.sh` script that can run few typical development scenarios using
short command. To simplify the development, you can create an alias in your shell
configuration file using `./onedata-gui-utils/scripts/install-dev-aliast.sh`.

```shell
alias dev="./onedata-gui-utils/scripts/dev.sh"
```

assuming that `onedata-gui-utils` is placed in the root of your project as a submodule
(e.g. `onepanel-gui`).

Example usage:

```shell
dev onenv
```

opens a splitted terminal window with two panes, one running `ember build` in watch mode
and the other running a script that copies the built GUI to the backend pod in watch mode.

Refer to the `scripts/dev.sh` script for more details and available commands.
