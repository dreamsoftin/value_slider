import 'package:flutter/material.dart';
import 'package:value_slider/src/value_pointer.dart';
import 'package:value_slider/value_slider.dart';

class HorizontalValueSlider extends StatelessWidget {
  /// A controller for scroll views whose items have the same size.
  final ValueSliderController controller;

  /// Maximum weight that the slider can be scrolled
  final int maxWeight;

  /// Minimum weight that the slider can be scrolled
  final int minWeight;

  /// If non-null, requires the child to have exactly this height.
  final double height;

  /// Pointer configuration
  final PointerConfig config;

  /// Size of each child in the main axis
  final double itemExtent;

  /// Describes the configuration for a vertical weight slider.
  final Widget? indicator;

  /// On optional listener that's called when the centered item changes.
  final ValueChanged<double> onChanged;

  final TextStyle? valueLabelStyle;

  const HorizontalValueSlider({
    Key? key,
    required this.controller,
    required this.maxWeight,
    required this.minWeight,
    required this.height,
    required this.config,
    required this.itemExtent,
    this.indicator,
    required this.onChanged,
    this.valueLabelStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification is ScrollUpdateNotification) {
          var changedVal = (controller.selectedItem / 10) + minWeight;
          onChanged(changedVal);
          controller.value = changedVal;
        }
        return false;
      },
      child: Container(
        color: Colors.red.withAlpha(10),
        constraints: BoxConstraints(
          maxHeight: 300,
        ),
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ValueListenableBuilder<double>(
                      valueListenable: controller,
                      builder: (context, value, child) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "$value lbs",
                            style: valueLabelStyle ??
                                const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w400,
                                ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Stack(
                children: [
                  SizedBox(
                    height: height,
                    child: Stack(
                      children: [
                        RotatedBox(
                          quarterTurns: 3,
                          child: ListWheelScrollView.useDelegate(
                            itemExtent: 12,
                            diameterRatio: 3.0,
                            controller: controller,
                            physics: FixedExtentScrollPhysics(),
                            perspective: 0.0001,
                            childDelegate: ListWheelChildBuilderDelegate(
                              childCount: (maxWeight - minWeight) * 10,
                              builder: (BuildContext context, int index) {
                                index = index + minWeight * 10;
                                return Center(
                                  child: index % 10 == 0
                                      ? RotatedBox(
                                          quarterTurns: 0,
                                          child: ValueListenableBuilder<double>(
                                            valueListenable: controller,
                                            builder: (context, value, child) {
                                              return ValuePointer(
                                                valuePointerStyle:
                                                    config.pointerValueStyle ??
                                                        const TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                rotateText: true,
                                                weight: (index - 1) / 10 ==
                                                            controller.value ||
                                                        index / 10 ==
                                                            controller.value ||
                                                        (index + 1) / 10 ==
                                                            controller.value
                                                    ? null
                                                    : (index / 10),
                                                color: config.colors[0]!,
                                                width:
                                                    config.height - config.gap,
                                                height: config.width,
                                              );
                                            },
                                          ),
                                        )
                                      : index % 5 == 0
                                          ? ValuePointer(
                                              color: config.colors[1]!,
                                              width: config.height -
                                                  (config.gap * 2),
                                              height: config.width - 1,
                                            )
                                          : ValuePointer(
                                              color: config.colors[2]!,
                                              width: config.height -
                                                  (config.gap * 2),
                                              height: config.width - 1,
                                            ),
                                );
                              },
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: RotatedBox(
                            quarterTurns: 3,
                            child: indicator ??
                                Container(
                                  alignment: Alignment.centerLeft,
                                  width: 1.5 * config.height,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.play_arrow,
                                        color: Colors.blue,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        width: config.height,
                                        height: config.width + 1,
                                      )
                                    ],
                                  ),
                                ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
