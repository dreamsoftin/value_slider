import 'dart:math';

import 'package:flutter/material.dart';

class ValuePointer extends StatelessWidget {
  ValuePointer({
    Key? key,
    this.width = 130.0,
    this.height = 3.0,
    this.color = Colors.grey,
    this.weight,
    this.rotateText = false,
    this.valuePointerStyle,
  }) : super(key: key);

  /// If non-null, requires the child to have exactly this Width.
  final double width;

  /// If non-null, requires the child to have exactly this height.
  final double height;

  /// The color of the gradation.
  final Color color;

  /// Weight to be displayed
  final double? weight;

  ///rotate text
  final bool rotateText;

  ///Value label style
  final TextStyle? valuePointerStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Transform.rotate(
          angle: rotateText ? pi / 2 : 0,
          child: Container(
            alignment: Alignment.center,
            width: 30,
            child: Text(
              weight?.toInt().toString() ?? "",
              style: valuePointerStyle,
            ),
          ),
        ),
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: color,
          ),
        ),
      ],
    );
  }
}
