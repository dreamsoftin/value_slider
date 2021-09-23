import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:value_slider/src/value_pointer.dart';

import '../value_slider.dart';
import 'pointer_config.dart';

class VerticalValueSlider extends StatefulWidget {
  VerticalValueSlider({
    Key? key,
    required this.controller,
    this.maxWeight = 300,
    this.minWeight = 0,
    this.height = 300.0,
    required this.config,
    this.itemExtent = 15.0,
    this.indicator,
    required this.onChanged,
    this.valueLabelStyle,
  })  : assert(itemExtent >= 0),
        assert(maxWeight >= 0),
        super(key: key);

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

  @override
  State<VerticalValueSlider> createState() => _VerticalValueSliderState();
}

class _VerticalValueSliderState extends State<VerticalValueSlider> {
  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification is ScrollUpdateNotification) {
          var changedVal =
              (widget.controller.selectedItem / 10) + widget.minWeight;
          widget.onChanged(changedVal);
          widget.controller.value = changedVal;
        }
        return false;
      },
      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: Stack(
              children: [
                SizedBox(
                  height: widget.height,
                  child: Stack(
                    children: [
                      ListWheelScrollView.useDelegate(
                        scrollBehavior: ScrollBehavior(),
                        itemExtent: 12,
                        diameterRatio: 3.0,
                        controller: widget.controller,
                        physics: FixedExtentScrollPhysics(),
                        perspective: 0.0001,
                        childDelegate: ListWheelChildBuilderDelegate(
                          childCount:
                              (widget.maxWeight - widget.minWeight) * 10,
                          builder: (BuildContext context, int index) {
                            index = index + widget.minWeight * 10;
                            return Center(
                              child: index % 10 == 0
                                  ? ValueListenableBuilder<double>(
                                      valueListenable: widget.controller,
                                      builder: (context, value, child) {
                                        return ValuePointer(
                                          weight: (index - 1) / 10 ==
                                                      widget.controller.value ||
                                                  index / 10 ==
                                                      widget.controller.value ||
                                                  (index + 1) / 10 ==
                                                      widget.controller.value
                                              ? null
                                              : (index / 10),
                                          color: widget.config.colors[0]!,
                                          width: widget.config.width -
                                              widget.config.gap,
                                          height: widget.config.height,
                                        );
                                      },
                                    )
                                  : index % 5 == 0
                                      ? ValuePointer(
                                          color: widget.config.colors[1]!,
                                          width: widget.config.width -
                                              (widget.config.gap * 2),
                                          height: widget.config.height - 1,
                                        )
                                      : ValuePointer(
                                          color: widget.config.colors[2]!,
                                          width: widget.config.width -
                                              (widget.config.gap * 2),
                                          height: widget.config.height - 1,
                                        ),
                            );
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          width: 1.5 * widget.config.width,
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
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                width: widget.config.width,
                                height: widget.config.height + 1,
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
          Expanded(
            flex: 7,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ValueListenableBuilder<double>(
                    valueListenable: widget.controller,
                    builder: (context, value, child) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${value}cms",
                          style: widget.valueLabelStyle ??
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
          )
        ],
      ),
    );
  }
}
