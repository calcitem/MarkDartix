# Debugging

## Use Visual Studio Code

The simplest way to debug is using the `Debug MarkDartix` configuration in Visual Studio Code. You can set breakpoints and use the `debugger` statement.

**Prerequisites:**

- [Dart](https://marketplace.visualstudio.com/items?itemName=Dart-Code.dart-code) extension for Visual Studio Code

## Use Flutter DevTools

You can use the built-in Flutter DevTools to debug your application. To start the DevTools, run `flutter run` in the terminal to launch your app in debug mode. After the app starts, you'll see a link to open DevTools in your terminal. Open the provided link in your browser to access the DevTools.

### Debug built application

To debug the built application, you can use the command-line options to enable debug mode as described below.

```shell
$ flutter run --release
```

## Debug slow startup performance

To analyze startup issues in your Flutter application, you can use the [Flutter DevTools](https://flutter.dev/docs/development/tools/devtools) suite, which includes various tools for profiling and analyzing performance.

1. Start your app in debug mode with `flutter run`.
2. Open the DevTools in your browser by following the link provided in the terminal output.
3. In DevTools, click on the 'Performance' tab to access the performance profiling tools.
4. Click the 'Record' button to start profiling your app's performance during startup or any other operation.
5. After the operation is complete, click 'Stop' to analyze the performance data collected.

The tools will provide insights into slow startup performance and help identify potential bottlenecks or issues in your application.
