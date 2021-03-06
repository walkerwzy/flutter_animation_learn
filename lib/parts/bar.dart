import 'dart:math';
import 'dart:ui' show lerpDouble;

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

import 'colorPalette.dart';

class BarChart {
  static const int barCount = 5;

  BarChart(this.bars) {
    assert(bars.length == barCount);
  }

  factory BarChart.empty() {
    return new BarChart(new List.filled(
      barCount,
      new Bar(0.0, Colors.transparent),
    ));
  }

  factory BarChart.random(Random random) {
    final Color color = ColorPalette.primary.random(random);
    return new BarChart(new List.generate(
      barCount,
      (i) => new Bar(random.nextDouble() * 100.0, color),
    ));
  }

  final List<Bar> bars;

  static BarChart lerp(BarChart begin, BarChart end, double t) {
    return new BarChart(new List.generate(
      barCount,
      (i) => Bar.lerp(begin.bars[i], end.bars[i], t),
    ));
  }
}

class BarChartTween extends Tween<BarChart> {
  BarChartTween(BarChart begin, BarChart end) : super(begin: begin, end: end);

  @override
  BarChart lerp(double t) => BarChart.lerp(begin, end, t);
}

class Bar {
  Bar(this.height, this.color);

  factory Bar.empty() => new Bar(0.0, Colors.transparent);

  factory Bar.random(Random random) {
    Random random = new Random(new DateTime.now().millisecondsSinceEpoch);
    return new Bar(
      random.nextDouble() * 100.0,
      // ColorPalette.primary.random(random),
      new Color.fromRGBO(random.nextInt(255), random.nextInt(255), random.nextInt(255), 1.0),
    );
  }

  final double height;
  final Color color;

  static Bar lerp(Bar begin, Bar end, double t) {
    return new Bar(
      lerpDouble(begin.height, end.height, t),
      Color.lerp(begin.color, end.color, t),
    );
  }
}

class BarTween extends Tween<Bar> {
  BarTween(Bar begin, Bar end) : super(begin: begin, end: end);

  @override
  Bar lerp(double t) => Bar.lerp(begin, end, t);
}


class BarChartPainter extends CustomPainter {
  static const barWidthFraction = 0.75;

  BarChartPainter(Animation<BarChart> animation)
      : animation = animation,
        super(repaint: animation);

  final Animation<BarChart> animation;

  @override
  void paint(Canvas canvas, Size size) {
    void drawBar(Bar bar, double x, double width, Paint paint) {
      paint.color = bar.color;
      final Rect rect = new Rect.fromLTWH(x, size.height - bar.height, width, bar.height);
      canvas.drawRRect(
        new RRect.fromRectXY(rect, 5.0, 5.0),
        paint,
      );
    }

    final paint = new Paint()..style = PaintingStyle.fill;
    final chart = animation.value;
    final barDistance = size.width / (1 + chart.bars.length);
    final barWidth = barDistance * barWidthFraction;
    var x = barDistance - barWidth / 2;
    for (final bar in chart.bars) {
      drawBar(bar, x, barWidth, paint);
      x += barDistance;
    }
  }

  @override
  bool shouldRepaint(BarChartPainter old) => false;
}

class BarChartPainterSingle extends CustomPainter {
  static const barWidth = 10.0;

  BarChartPainterSingle(Animation<Bar> animation)
      : animation = animation,
        super(repaint: animation);

  final Animation<Bar> animation;

  @override
  void paint(Canvas canvas, Size size) {
    final bar = animation.value;
    final paint = new Paint()
      ..color = bar.color
      ..style = PaintingStyle.fill;
      final rect = new Rect.fromLTWH(
        (size.width - barWidth) / 2.0,
        size.height - bar.height,
        barWidth,
        bar.height,
      );
    canvas.drawRRect(
      new RRect.fromRectXY(rect, barWidth/2, barWidth/2),
      paint,
    );
  }

  @override
  bool shouldRepaint(BarChartPainter old) => false;
}