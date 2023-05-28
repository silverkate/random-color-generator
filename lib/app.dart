import 'package:flutter/material.dart';
import 'package:random_color_generator/pages/color_generation_page.dart';

/// Material App Widget.
class App extends StatelessWidget {
  /// App constructor.
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random color generation',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ColorGenerationPage(),
    );
  }
}
