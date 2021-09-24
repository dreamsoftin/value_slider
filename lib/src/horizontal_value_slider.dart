import 'package:flutter/material.dart';

import 'package:value_slider/src/value_pointer.dart';
import 'package:value_slider/value_slider.dart';

class HorizontalValueSlider extends StatelessWidget {
  /// A controller for scroll views whose items have the same size.
  final ValueSliderController controller;

  /// Maximum weight that the slider can be scrolled
  final int maxValue;

  /// Minimum weight that the slider can be scrolled
  final int minValue;

  /// If non-null, requires the child to have exactly this height.
  final double? height;

  /// If non-null, requires the child to have exactly this height.
  final double? width;

  /// Pointer configuration
  final PointerConfig config;

  /// Size of each child in the main axis
  final double itemExtent;

  /// Describes the configuration for a vertical weight slider.
  final Widget? indicator;

  /// On optional listener that's called when the centered item changes.
  final ValueChanged<double> onChanged;

  /// Value label TextStyle
  final TextStyle? valueLabelStyle;

  final Function(BuildContext context, double value)? builder;

  const HorizontalValueSlider({
    Key? key,
    required this.controller,
    required this.maxValue,
    required this.minValue,
    this.height,
    this.width,
    required this.config,
    required this.itemExtent,
    this.indicator,
    required this.onChanged,
    this.valueLabelStyle,
    this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification is ScrollUpdateNotification) {
          var changedVal = (controller.selectedItem / 10) + minValue;
          onChanged(changedVal);
          controller.value = changedVal;
        }
        return false;
      },
      child: Container(
        width: width,
        height: height ?? 250,
        constraints: BoxConstraints(
          maxWidth: size.width,
          maxHeight: size.height,
        ),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                child: ValueListenableBuilder<double>(
                  valueListenable: controller,
                  builder: (context, value, child) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "$value",
                            style: valueLabelStyle ??
                                const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w400,
                                ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Stack(
                children: [
                  RotatedBox(
                    quarterTurns: 3,
                    child: ListWheelScrollView.useDelegate(
                      squeeze: 1.4,
                      scrollBehavior: ScrollBehavior(),
                      itemExtent: 12,
                      diameterRatio: 3.0,
                      controller: controller,
                      physics: BouncingScrollPhysics(),
                      perspective: 0.0001,
                      childDelegate: ListWheelChildBuilderDelegate(
                        childCount: (maxValue - minValue) * 10,
                        builder: (BuildContext context, int index) {
                          index = index + minValue * 10;
                          return Center(
                            child: index % 10 == 0
                                ? ValueListenableBuilder<double>(
                                    valueListenable: controller,
                                    builder: (context, value, child) {
                                      return ValuePointer(
                                        rotateText: true,
                                        valuePointerStyle:
                                            config.pointerValueStyle,
                                        weight: (index - 1) / 10 ==
                                                    controller.value ||
                                                index / 10 ==
                                                    controller.value ||
                                                (index + 1) / 10 ==
                                                    controller.value
                                            ? null
                                            : (index / 10),
                                        color: config.colors[0]!,
                                        width: config.width,
                                        height: config.height,
                                      );
                                    },
                                  )
                                : index % 5 == 0
                                    ? ValuePointer(
                                        color: config.colors[1]!,
                                        width: config.width - (config.gap),
                                        height: config.height,
                                      )
                                    : ValuePointer(
                                        color: config.colors[2]!,
                                        width: config.width - (config.gap),
                                        height: config.height,
                                      ),
                          );
                        },
                      ),
                    ),
                  ),
                  indicator ??
                      RotatedBox(
                        quarterTurns: 3,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.play_arrow,
                                color: Colors.blue,
                                size: 26,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                width: 75,
                                height: 3,
                              )
                            ],
                          ),
                        ),
                      )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
