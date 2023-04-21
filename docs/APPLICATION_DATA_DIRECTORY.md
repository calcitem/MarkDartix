# Application Data Directory

The per-user application data directory is located in the following directory:

- `%APPDATA%\markdartix` on Windows
- `$XDG_CONFIG_HOME/markdartix` or `~/.config/markdartix` on Linux
- `~/Library/Application Support/markdartix` on macOS

When [portable mode](PORTABLE.md) is enabled, the directory location is either the `--user-data-dir` parameter or `markdartix-user-data` directory.
