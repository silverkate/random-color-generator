import 'dart:async';

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
  final _isPausedNotifier = ValueNotifier<bool>(true);

  StreamSubscription<dynamic>? _autoChangeBackgroundStream;

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
            floatingActionButton: ValueListenableBuilder<bool>(
              valueListenable: _isPausedNotifier,
              builder: (_, isPaused, ___) => FloatingActionButton(
                backgroundColor: isPaused ? Colors.green : Colors.red,
                onPressed: _setAutomaticSwitch,
                child: Icon(
                  isPaused ? Icons.play_arrow : Icons.pause,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _colorNotifier.dispose();
    _isPausedNotifier.dispose();
    _autoChangeBackgroundStream?.cancel();
    super.dispose();
  }

  void _changeBackgroundColor() {
    _colorNotifier.value = _colorGenerator.getRandomColor();
  }

  void _setAutomaticSwitch() {
    if (_isPausedNotifier.value) {
      _autoChangeBackgroundStream = Stream.periodic(const Duration(seconds: 2))
          .listen((_) => _changeBackgroundColor());
    } else {
      _autoChangeBackgroundStream?.cancel();
    }

    _isPausedNotifier.value = !_isPausedNotifier.value;
  }
}
