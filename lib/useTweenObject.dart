import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

import './parts/bar.dart';

void main() {
  runApp(new MaterialApp(home: new TweenChartPage()));
}

class TweenChartPage extends StatefulWidget {
  @override
  TweenChartPageState createState() => new TweenChartPageState();
}

class TweenChartPageState extends State<TweenChartPage> with TickerProviderStateMixin {
  final random = new Random();
  AnimationController animation;
  BarChartTween tween;

  @override
  void initState() {
    super.initState();
    animation = new AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    tween = new BarChartTween(new BarChart.empty(), new BarChart.random(random));
    animation.forward();
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  void changeData() {
    setState(() {
      tween = new BarChartTween(tween.evaluate(animation), new BarChart.random(random));
      animation.forward(from: 0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("bar tween object"),),
      body: new Center(
        child: new CustomPaint(
          size: new Size(200.0, 100.0),
          painter: new BarChartPainter(tween.animate(animation)),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.refresh),
        onPressed: changeData,
      ),
    );
  }
}