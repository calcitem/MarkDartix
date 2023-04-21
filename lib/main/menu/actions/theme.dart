void selectTheme(String theme) {
  // You'll need to handle the communication between different parts of your app differently.
  // One option is to use a state management solution like Provider, Riverpod, or BLoC to manage the theme.
  // Another option is to pass callbacks between widgets to trigger a theme change.

  // For example, with Provider:
  // context.read<ThemeNotifier>().updateTheme(theme);
}
