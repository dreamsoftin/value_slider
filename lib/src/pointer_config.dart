import 'package:flutter/material.dart';

class PointerConfig {
  PointerConfig({
    required this.width,
    required this.height,
    this.pointerValueStyle,
    this.colors = const [Colors.grey, Colors.grey, Colors.grey],
    this.gap = 30.0,
  }) : assert(colors.length == 3);

  /// If non-null, requires the child to have exactly this Width.
  final double width;

  /// If non-null, requires the child to have exactly this height.
  final double height;

  /// The color of the gradation.
  List<Color?> colors;

  /// Gap by Pointer Location.
  final double gap;

  /// Value Label Style
  final TextStyle? pointerValueStyle;
}
