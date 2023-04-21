# Portable Mode

MarkDartix stores all user configuration inside the [application data directory](APPLICATION_DATA_DIRECTORY.md) that can be changed with `--user-data-dir` command-line flag.

## Linux and Windows

On Linux and Windows you can also create a directory called `markdartix-user-data` to save all user data inside the directory. Like:

```
markdartix-portable/
 ├── markdartix (Linux) or MarkDartix.exe (Windows)
 ├── markdartix-user-data/
 ├── resources/
 ├── THIRD-PARTY-LICENSES.txt
 └── ...
```
