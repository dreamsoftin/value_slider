import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:value_slider/src/value_pointer.dart';

import '../value_slider.dart';
import 'pointer_config.dart';

class VerticalValueSlider extends StatefulWidget {
  VerticalValueSlider({
    Key? key,
    required this.controller,
    this.maxValue = 300,
    this.minValue = 0,
    this.height = 300.0,
    required this.config,
    this.itemExtent = 15.0,
    this.indicator,
    required this.onChanged,
    this.valueLabelStyle,
    this.builder,
    this.width,
    this.squeeze = 1,
  })  : assert(itemExtent >= 0),
        assert(maxValue >= 0),
        super(key: key);

  /// A controller for scroll views whose items have the same size.
  final ValueSliderController controller;

  /// Maximum weight that the slider can be scrolled
  final int maxValue;

  /// Minimum weight that the slider can be scrolled
  final int minValue;

  /// If non-null, requires the child to have exactly this height.
  final double? height;

  /// If non-null, requires the child to have exactly this width.
  final double? width;

  /// Pointer configuration
  final PointerConfig config;

  /// Size of each child in the main axis
  final double itemExtent;

  /// Describes the configuration for a vertical weight slider.
  final Widget? indicator;

  /// On optional listener that's called when the centered item changes.
  final ValueChanged<double> onChanged;

  /// Value label Style.
  final TextStyle? valueLabelStyle;

  /// Builder to build custom widget when value changes.
  final Function(BuildContext, double)? builder;

  /// Squeeze
  final double squeeze;

  @override
  State<VerticalValueSlider> createState() => _VerticalValueSliderState();
}

class _VerticalValueSliderState extends State<VerticalValueSlider> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification is ScrollUpdateNotification) {
          var changedVal =
              (widget.controller.selectedItem / 10) + widget.minValue;
          widget.onChanged(changedVal);
          widget.controller.value = changedVal;
        }
        return false;
      },
      child: Container(
        width: widget.width,
        height: widget.height ?? 250,
        constraints: BoxConstraints(
          maxWidth: size.width,
          maxHeight: size.height,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 7,
              child: Stack(
                children: [
                  ListWheelScrollView.useDelegate(
                    squeeze: widget.squeeze,
                    scrollBehavior: ScrollBehavior(),
                    itemExtent: 12,
                    diameterRatio: 3.0,
                    controller: widget.controller,
                    physics: BouncingScrollPhysics(),
                    perspective: 0.0001,
                    childDelegate: ListWheelChildBuilderDelegate(
                      childCount: (widget.maxValue - widget.minValue) * 10,
                      builder: (BuildContext context, int index) {
                        index = index + widget.minValue * 10;
                        return Center(
                          child: index % 10 == 0
                              ? ValueListenableBuilder<double>(
                                  valueListenable: widget.controller,
                                  builder: (context, value, child) {
                                    return ValuePointer(
                                      valuePointerStyle:
                                          widget.config.pointerValueStyle,
                                      weight: (index - 1) / 10 ==
                                                  widget.controller.value ||
                                              index / 10 ==
                                                  widget.controller.value ||
                                              (index + 1) / 10 ==
                                                  widget.controller.value
                                          ? null
                                          : (index / 10),
                                      color: widget.config.colors[0]!,
                                      width: widget.config.width,
                                      height: widget.config.height,
                                    );
                                  },
                                )
                              : index % 5 == 0
                                  ? ValuePointer(
                                      color: widget.config.colors[1]!,
                                      width: widget.config.width -
                                          (widget.config.gap),
                                      height: widget.config.height,
                                    )
                                  : ValuePointer(
                                      color: widget.config.colors[2]!,
                                      width: widget.config.width -
                                          (widget.config.gap),
                                      height: widget.config.height,
                                    ),
                        );
                      },
                    ),
                  ),
                  widget.indicator ??
                      Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.play_arrow,
                              color: Colors.blue,
                              size: 26,
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              width: 90,
                              height: widget.config.height + 1,
                            )
                          ],
                        ),
                      )
                ],
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                child: ValueListenableBuilder<double>(
                  valueListenable: widget.controller,
                  builder: (context, value, child) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "$value",
                            style: widget.valueLabelStyle ??
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
            )
          ],
        ),
      ),
    );
  }
}
