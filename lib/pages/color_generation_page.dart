import 'package:flutter/material.dart';
import 'package:random_color_generator/services/color_generator_service.dart';

/// Main page of the application.
///
/// Displays the 'Hello there' text. On screen tap changes the background color.
class ColorGenerationPage extends StatefulWidget {
  /// ColorGenerationPage constructor.
  const ColorGenerationPage({super.key});

  @override
  State<ColorGenerationPage> createState() => _ColorGenerationPageState();
}

class _ColorGenerationPageState extends State<ColorGenerationPage> {
  static const _fontSize = 24.0;

  final _colorGenerator = ColorGeneratorService.instance;
  final _colorNotifier = ValueNotifier<Color>(Colors.white);

  @override
  void initState() {
    super.initState();
    _changeBackgroundColor();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Color>(
      valueListenable: _colorNotifier,
      builder: (_, color, __) {
        return GestureDetector(
          onTap: _changeBackgroundColor,
          child: Scaffold(
            body: AnimatedContainer(
              color: color,
              duration: const Duration(seconds: 1),
              child: GestureDetector(
                onTap: _changeBackgroundColor,
                child: Center(
                  child: Text(
                    'Hello there',
                    style: TextStyle(
                      color: _colorGenerator.getReadableTextColor(
                        backgroundColor: color,
                      ),
                      fontSize: _fontSize,
                    ),
                  ),
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.green,
              elevation: 0,
              onPressed: _setAutomaticSwitch,
              child: const Icon(Icons.play_arrow),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _colorNotifier.dispose();
    super.dispose();
  }

  void _changeBackgroundColor() {
    _colorNotifier.value = _colorGenerator.getRandomColor();
  }

  void _setAutomaticSwitch() {
    // TODO: implement.
  }
}
