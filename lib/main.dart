import 'package:flutter/material.dart';
import 'package:octo_search/features/user_search/screen/user_search.dart';

void main() {
  runApp(const OctoSearch());
}

class OctoSearch extends StatelessWidget {
  const OctoSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OctoSearch',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.dark, // TODO: change this to ThemeMode.system later.
      home: const UserSearchScreen(),
    );
  }
}
