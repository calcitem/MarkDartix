import 'package:flutter/material.dart';
// Import the required packages and custom components
// Example: import 'package:your_package/components/title_bar.dart';
// Example: import 'package:your_package/components/side_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'your_bloc.dart'; // Import your custom Bloc

class PreferencesPage extends StatefulWidget {
  @override
  _PreferencesPageState createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  // Declare and initialize your state properties and controllers
  // ...

  @override
  void initState() {
    super.initState();
    // Call your event listeners and other initialization methods here
    // ...
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<YourBloc, YourState>(
      builder: (context, state) {
        // Your state properties and conditions based on the state
        // ...

        return Scaffold(
          body: Row(
            children: [
              // Include your custom SideBar widget
              SideBar(),
              Expanded(
                child: Column(
                  children: [
                    if (showCustomTitleBar)
                      TitleBar(), // Include your custom TitleBar widget
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(
                            top: showCustomTitleBar ? 0 : 50,
                            left: 20,
                            right: 20),
                        child: SingleChildScrollView(
                          // Add your route handling logic here
                          child: Text('Preferences content goes here'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    // Dispose of your controllers and other resources here
    // ...
    super.dispose();
  }

  // Your event listeners and other methods here
  // ...
}
