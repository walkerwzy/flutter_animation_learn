import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

import '../parts/bar2.dart';

void main() {
  runApp(new MaterialApp(home: new ChartPageArray()));
}

class ChartPageArray extends StatefulWidget {
  @override
  ChartPageArrayState createState() => new ChartPageArrayState();
}

class ChartPageArrayState extends State<ChartPageArray> with TickerProviderStateMixin {
  static const size = const Size(200.0, 100.0);
  final random = new Random();
  AnimationController animation;
  BarChartVTween tween;

  @override
  void initState() {
    super.initState();
    animation = new AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    tween = new BarChartVTween(
      new BarChartV.empty(size),
      new BarChartV.random(size, random),
    );
    animation.forward();
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  void changeData() {
    setState(() {
      tween = new BarChartVTween(
        tween.evaluate(animation),
        new BarChartV.random(size, random),
      );
      animation.forward(from: 0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("variable array"),),
      body: new Center(
        child: new CustomPaint(
          size: size,
          painter: new BarChartVPainter(tween.animate(animation)),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.refresh),
        onPressed: changeData,
      ),
    );
  }
}