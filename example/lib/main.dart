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
  late ValueSliderController _vcontroller;
  late ValueSliderController _hcontroller;
  double _weight = 50.5;
  int _minWeight = 10;

  @override
  void initState() {
    super.initState();
    _vcontroller =
        ValueSliderController(initialWeight: _weight, minWeight: _minWeight);
    _hcontroller =
        ValueSliderController(initialWeight: _weight, minWeight: _minWeight);
  }

  @override
  void dispose() {
    _vcontroller.dispose();
    _hcontroller.dispose();
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
        children: [
          VerticalValueSlider(
            itemExtent: 5,
            controller: _vcontroller,
            minValue: 100,
            maxValue: 250,
            config: PointerConfig(
              gap: 0,
              pointerValueStyle: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
              width: 50,
              height: 2.5,
              colors: [
                Colors.grey[500],
                Colors.grey[300],
                Colors.grey[200],
              ],
            ),
            onChanged: (value) {},
            height: 200,
          ),
          HorizontalValueSlider(
            itemExtent: 5,
            controller: _hcontroller,
            minValue: 100,
            maxValue: 250,
            config: PointerConfig(
              gap: 0,
              pointerValueStyle: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
              width: 50,
              height: 2.5,
              colors: [
                Colors.grey[500],
                Colors.grey[300],
                Colors.grey[200],
              ],
            ),
            onChanged: (value) {
              //log("Value $value");
            },
            height: 200,
          ),
        ],
      ),
    );
  }
}
