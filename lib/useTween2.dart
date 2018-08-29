import 'dart:math';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

// Tween的正确用法, 传递到Paint对象里
// 仔细阅读代码, 可以发现几乎是跟animatedWidgets的用法是一样的
// 都是把animation传入, 一个传给listenable, 一个传给repaint

// 这里机制不同了注意
// 没有重建 widget tree(rebuild / relayout / repaint) -> flutter自己对比的该不该重建
// 而是只应用了repaint方法重绘

void main() {
  runApp(new MaterialApp(home: new ChartPageTween()));
}

class ChartPageTween extends StatefulWidget {
  @override
  ChartPageTweenState createState() => new ChartPageTweenState();
}

class ChartPageTweenState extends State<ChartPageTween> with TickerProviderStateMixin {
  final random = new Random();
  int dataSet = 50;
  AnimationController animation;
  Tween<double> tween;

  @override
  void initState() {
    super.initState();
    animation = new AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    tween = new Tween<double>(begin: 0.0, end: dataSet.toDouble());
    animation.forward();
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  void changeData() {
    setState(() {
      dataSet = random.nextInt(100);
      tween = new Tween<double>(
        begin: tween.evaluate(animation), // current interploted value of animation
        end: dataSet.toDouble(),
      );
      animation.forward(from: 0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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

class BarChartPainter extends CustomPainter {
  static const barWidth = 10.0;

  BarChartPainter(Animation<double> animation)
      : animation = animation,
        super(repaint: animation);

  final Animation<double> animation;

  @override
  void paint(Canvas canvas, Size size) {
    final barHeight = animation.value;
    final paint = new Paint()
      ..color = Colors.blue[400]
      ..style = PaintingStyle.fill;
    Rect rect = new Rect.fromLTWH((size.width - barWidth) / 2.0,
        size.height - barHeight, barWidth, barHeight);
    canvas.drawRRect(
      new RRect.fromRectXY(rect, barWidth/2, barWidth/2),
      paint,
    );
  }

  @override
  bool shouldRepaint(BarChartPainter old) => false;
}