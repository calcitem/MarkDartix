# Build Instructions

Clone the repository:

```
git clone https://github.com/calcitem/markdartix.git
```

### Prerequisites

Before you can get started developing, you need to set up your build environment:

- Flutter SDK
- Dart SDK
- Android Studio or another suitable IDE for Flutter development

**Additional development dependencies on Linux:**

- libX11 (with headers)
- libxkbfile (with headers)
- libsecret (with headers)
- libfontconfig (with headers)

On Debian-based Linux: `sudo apt-get install libx11-dev libxkbfile-dev libsecret-1-dev libfontconfig-dev`

On Red Hat-based Linux: `sudo dnf install libX11-devel libxkbfile-devel libsecret-devel fontconfig-devel`

**Additional development dependencies on Windows:**

- Windows 11 SDK (only needed before Windows 11)
- Visual Studio 2022 (preferred)

### Let's build

1. Go to the `markdartix` folder
2. Run `flutter pub get` to fetch dependencies
3. Run `flutter build` to build the MarkDartix binaries for your OS
4. MarkDartix binary is located under the `build` folder

Copy the build app to applications folder, or if on Windows run the executable installer.

### Run

```
$ flutter run
```
