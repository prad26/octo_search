import 'package:flutter/material.dart';
import 'package:octo_search/features/user_search/screen/user_search.dart';

/// The main entry point for the OctoSearch application.
void main() {
  runApp(const OctoSearch());
}

/// The root widget of the OctoSearch application.
///
/// This widget sets up the [MaterialApp] with the necessary themes and initial route.
class OctoSearch extends StatelessWidget {
  const OctoSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OctoSearch',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        scaffoldBackgroundColor: Colors.white,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueGrey,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.system,
      home: const UserSearchScreen(),
    );
  }
}
