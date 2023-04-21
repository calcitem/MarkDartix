# Linux Installation Instructions

## AppImage

[Download the AppImage](https://github.com/calcitem/markdartix/releases/latest) and type the following:

1. `chmod +x markdartix-%version%-x86_64.AppImage`
2. `./markdartix-%version%-x86_64.AppImage`
3. Now you can execute MarkDartix.

### Installation

You cannot really install an AppImage. It's a file which can run directly after getting executable permission. To integrate it into desktop environment, you can either create desktop entry manually **or** use [AppImageLauncher](https://github.com/TheAssassin/AppImageLauncher).

#### Desktop file creation

See [example desktop file](https://github.com/calcitem/markdartix/blob/develop/resources/linux/markdartix.desktop).

```bash
$ curl -L https://raw.githubusercontent.com/calcitem/markdartix/develop/resources/linux/markdartix.desktop -o $HOME/.local/share/applications/markdartix.desktop

# Update the Exec in desktop file to your real markdartix command. Specify Path if necessary.
$ vim $HOME/.local/share/applications/markdartix.desktop

$ update-desktop-database $HOME/.local/share/applications/
```

#### AppImageLauncher integration

You can integrate the AppImage into the system via [AppImageLauncher](https://github.com/TheAssassin/AppImageLauncher). It will handle the desktop entry automatically.

### Uninstallation

1. Delete AppImage file.
2. Delete your desktop file if exists.
3. Delete your user settings: `~/.config/markdartix`

### Custom launch script

1. Save AppImage somewhere. Let's say `~/bin/markdartix.AppImage`
2. `chmod +x ~/bin/markdartix.AppImage`
3. Create a launch script:
   
   ```sh
   #!/bin/bash
   DESKTOPINTEGRATION=0 ~/bin/markdartix.AppImage
   ```

### Known issues

- MarkDartix is always integrated into desktop environment after updating

## Binary

You can download the latest `markdartix-%version%.tar.gz` package from the [release page](https://github.com/calcitem/markdartix/releases/latest). You may need to install electron dependencies.
