# Project Architecture

## Overview

- `.`: Configuration files

- `pubspec.yaml`: Project settings

- `build/`: Contains generated binaries

- `dist/`: Build files for deployment

- `docs/`: Documentation and assets

- `resources/`: Application assets used at build time

- `lib`: MarkDartix source code
  - `common/`: Common source files that only require Dart APIs. Code from this folder can be used in all other folders.
  - `main/`: Main process source files that require Flutter main-process APIs. `main` files can use `common` source code.
  - `muya/`: MarkDartix's backend that only allows pure Dart, BOM and DOM APIs. Don't use Flutter or other platform-specific APIs!
  - `renderer`: Frontend that requires Flutter renderer-process APIs and may use `common` or `muya` source code.
  
- `assets/`: Application assets (images, themes, etc)

- `test/`: Contains (unit) tests

## Introduction to MarkDartix

MarkDartix is a realtime preview (WYSIWYG) editor for markdown with various markdown extensions, and our philosophy is to keep things clean, simple, and minimal. The application is built with Dart and Flutter. Currently, we're using a few platform-specific libraries, and our UI is built with Flutter. MarkDartix can be split into three parts: the core called Muya, the main process, and the renderer process.

Muya provides realtime preview and markdown editing via multiple modules based on a block structure. You can imagine it as the editor backend with modules for markdown parsing, data store as block structure, markdown document transformations according to CommonMark and GitHub Flavored Markdown specification with some extra specifications, event listeners, and an exporter to generate standalone HTML and markdown files but also to generate the WYSIWYG editor. Muya is single-threaded as well as MarkDartix but uses asynchronous functions to boost performance.

> NOTE: MarkDartix's source-code editor is provided by a Dart-based code editor and is not well optimized nor feature-rich. It's not part of Muya and is an editor (renderer process) feature that loads the markdown text from Muya (export), operates on it, and re-imports the text into Muya when switching to preview mode.

> NOTE: Muya requires a core refactoring to provide better modularization, APIs, and plugins. Furthermore, the data structure needs improvements for better performance and stability.

The editor represents the view and is split into two parts. The first is the main process that has full access to Flutter and all OS features. It's mainly used for IO, user interaction with native dialogs, and controls the editor windows. The main process should not (be long) blocked by synchronous operations. The renderer process is the real editor and also a host for Muya. It's responsible for all graphical elements (`lib/renderer/components`), data (`lib/renderer/store`), and data synchronization. A renderer process is spawned for each window, operates on its own, and is controlled by the main process. It contains two text editors: the realtime preview editor provided by Muya and the source-code one by a Dart-based code editor with special features such as tabs, sidebar, and editing features.

### Application entry points

There are two entry points to the application:

- `src/main/index.js` for the main process that is executed first and only once per instance. Once the application is initialized, it's safe to access all the environment variables and single-instances and the application (`App`) is started (`src/main/app/index.js`). You can use the application after `App::init()` is run successfully.
- `src/renderer/main.js` for each editor window. At the beginning libraries are loaded, the window is initialized and Vue components are mounted.

### How Muya work

TBD

- Overview about Muya components
- How Muya work internal
- Data structure

### Main and renderer process communication

Main- and renderer process communicate asynchronously via [inter-process communication (IPC)](code/IPC.md) and it's mainly used for IO and user interaction with native dialogs.

### Editor window (renderer process)

TBD

### Examples

#### Opening a markdown document and rendering it

`MarkdownDocument` is a document that represents a markdown file on disk or an untitled document. To get a markdown document, you can use the `loadMarkdownFile` function that asynchronously returns a `RawMarkdownDocument` (= `MarkdownDocument` with some additional information) in the main process.

**Overall steps to open a file:**

1. Click `File -> Open File`, and a file dialog is shown that emits `app-open-file-by-id` with the editor window id to open the file in and the resolved absolute file path.
2. The application (`App` instance) tries to find the specified editor and calls `openTab` on the editor window. A new editor window is created if no editor window exists.
3. The editor window tries to load the markdown file via `loadMarkdownFile` and sends the result via the `mt::open-new-tab` event to the renderer process.
  - Each opened file is also added to the filesystem watcher, and the full path is saved to track the opened file in the current editor window.
4. The event is triggered in `lib/renderer/store/editor.dart` (renderer process), does some checks, and creates a new document state that represents a markdown document and tab state.
5. The newly created tab is either opened, and the `file-changed` event is emitted or just added to the tab state.
6. Both Muya and the source-code editor listen to this event and change the markdown document accordingly.

> NOTE: We currently have no high-level APIs to make changes to the document text or lines automatically. All modifications require user interaction!
