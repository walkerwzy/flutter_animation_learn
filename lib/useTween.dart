import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

// 演示把每次动画的起始值重新生成一个Tween对象, play 一遍

void main() {
  runApp(new MaterialApp(home: new ChartPage2()));
}

class ChartPage2 extends StatefulWidget {
  @override
  ChartPage2State createState() => new ChartPage2State();
}

class ChartPage2State extends State<ChartPage2> with TickerProviderStateMixin {
  final random = new Random();
  int dataSet = 50;
  Animation<double> myAnimation;
  AnimationController animation;
  double startHeight; // Strike one.
  double currentHeight; // Strike two.
  double endHeight; // Strike three. Refactor.

  @override
  void initState() {
    super.initState();
    animation = new AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    startHeight = 0.0; // Strike two.
    currentHeight = 0.0;
    endHeight = dataSet.toDouble();
    setupAnimation();
    animation.forward();
  }

  void setupAnimation() {
    // 每次生成一个新的animation controller
    animation = new AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    myAnimation = new Tween(begin: startHeight, end: endHeight).animate(animation)
    ..addListener(() {
        setState(() {});
      })
    ..addStatusListener((status) {
      if(status == AnimationStatus.completed) {
        currentHeight = endHeight;
      }
    });
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  void changeData() {
    setState(() {
      startHeight = currentHeight;    // Strike three. Refactor.
      dataSet = random.nextInt(100);
      endHeight = dataSet.toDouble();
      // animation.forward(from: 0.0);
      setupAnimation();
      animation.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Tween"),),
      body: new Center(
        child: new CustomPaint(
          size: new Size(200.0, 100.0),
          // painter: new BarChartPainter(currentHeight),
          painter: new BarChartPainter(myAnimation.value),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.refresh),
        onPressed: changeData,
      ),
    );
  }
}

class BarChartPainter extends CustomPainter {
  static const barWidth = 10.0;

  BarChartPainter(this.barHeight);

  final double barHeight;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = new Paint()
      ..color = Colors.blue[400]
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      new Rect.fromLTWH(
        (size.width - barWidth) / 2.0,
        size.height - barHeight,
        barWidth,
        barHeight,
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(BarChartPainter old) => barHeight != old.barHeight;
}
