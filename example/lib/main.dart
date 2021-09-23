import 'package:flutter/material.dart';
import 'package:value_slider/value_slider.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ValueSliderController _controller;
  double _weight = 50.5;
  int _minWeight = 10;

  @override
  void initState() {
    super.initState();
    _controller =
        ValueSliderController(initialWeight: _weight, minWeight: _minWeight);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vertical Weight Slider Example"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: VerticalValueSlider(
              itemExtent: 10,
              controller: _controller,
              minWeight: 100,
              maxWeight: 250,
              config: PointerConfig(
                pointerValueStyle: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
                width: 100,
                height: 3,
                colors: [
                  Colors.grey[500],
                  Colors.grey[300],
                  Colors.grey[200],
                ],
              ),
              onChanged: (value) {
                setState(() {
                  _weight = value;
                });
              },
              height: 200,
            ),
          ),
          // Container(
          //   child: VerticalValueSlider(
          //     itemExtent: 10,
          //     controller: _controller,
          //     minWeight: 100,
          //     maxWeight: 250,
          //     config: PointerConfig(
          //       pointerValueStyle: TextStyle(
          //         fontSize: 13,
          //         fontWeight: FontWeight.bold,
          //       ),
          //       width: 3,
          //       height: 100,
          //       colors: [
          //         Colors.grey[500],
          //         Colors.grey[300],
          //         Colors.grey[200],
          //       ],
          //     ),
          //     onChanged: (value) {
          //       setState(() {
          //         _weight = value;
          //       });
          //     },
          //     height: 200,
          //   ),
          // ),
        ],
      ),
    );
  }
}
