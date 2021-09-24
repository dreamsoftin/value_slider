import 'package:flutter/cupertino.dart';

class ValueSliderController extends FixedExtentScrollController
    implements ValueNotifier<double> {
  /// Maximum weight that the slider can be scrolled
  final int maxValue;

  /// Minimum weight that the slider can be scrolled
  final int minValue;

  @override
  double value;

  ValueSliderController({
    this.minValue = 0,
    this.maxValue = 100,
    this.value = 0,
  })  : assert(maxValue >= 0),
        super(initialItem: ((value - minValue) * 10).toInt());
}
