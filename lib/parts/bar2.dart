import 'dart:math';
import 'dart:ui' show lerpDouble;

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

import 'colorPalette.dart';

class BarChartV {
  BarChartV(this.bars);

  factory BarChartV.empty(Size size) {
    return new BarChartV(<Bar>[]);
  }

  factory BarChartV.random(Size size, Random random) {
    const barWidthFraction = 0.75;
    const minBarDistance = 20.0;
    final barCount = random.nextInt((size.width / minBarDistance).floor()) + 1;
    final barDistance = size.width / (1 + barCount);
    final barWidth = barDistance * barWidthFraction;
    final startX = barDistance - barWidth / 2;
    final color = ColorPalette.primary.random(random);
    final bars = new List.generate(
      barCount,
      (i) => new Bar(
            startX + i * barDistance,
            barWidth,
            random.nextDouble() * size.height,
            color,
          ),
    );
    return new BarChartV(bars);
  }

  final List<Bar> bars;

  static BarChartV lerp(BarChartV begin, BarChartV end, double t) {
    final barCount = max(begin.bars.length, end.bars.length);
    // final bars = new List.generate(
    //   barCount,
    //   (i) => Bar.lerp(
    //         begin._barOrNull(i) ?? end.bars[i].collapsed,
    //         end._barOrNull(i) ?? begin.bars[i].collapsed,
    //         t,
    //       ),
    // );
    // 比如5个变成7个, 那么就让第6, 7个的"初始位置", 变成结果里的初始位置
    // 而5里面的索引6和7显然是不存在的.
    // 结果就是超慢的动画下, 会看到第6, 7个的位置有两根柱子慢慢显现, 但位置不变

    // 这个思路还是, 要想线性地动起来, 就不能无中生有, 哪怕本来没有,
    // 也要造一个隐形的对象

    // 现在利用Flutter SDK的lerp对空值的特性进行改写
    // lerpDouble treats null as zero, unless both animation end-points are null.
    // 即 null 也是0, 所以可以利用这一点
    // 以不要每次都生成一个collapsed的对象仅仅是为了生成一个不存在的元素再来做动画
    final bars = new List.generate(
      barCount, 
      (i) => Bar.lerp(begin._barOrNull(i), end._barOrNull(i), t)
      // 从这一句我们就知道, 要么 begin 要么 end, 总有超出索引的值产生,
      // 但我们这里不处理, 留待 bar.lerp 方法自行处理
    );
    return new BarChartV(bars);
  }

  Bar _barOrNull(int index) => (index < bars.length ? bars[index] : null);
}

class BarChartVTween extends Tween<BarChartV> {
  BarChartVTween(BarChartV begin, BarChartV end) : super(begin: begin, end: end);

  @override
  BarChartV lerp(double t) => BarChartV.lerp(begin, end, t);
}

class Bar {
  Bar(this.x, this.width, this.height, this.color);

  final double x;
  final double width;
  final double height;
  final Color color;

  // Bar get collapsed => new Bar(x, 0.0, 0., color);

  /// 公式:
  /// lerp(C(x1, y1), C(x2, y2), t) == C(lerp(x1, x2, t), lerp(y1, y2, t))
  /// 即组合的渐变, 等于渐变的组合, 这样就把对象的渐变拆成了属性值的渐变
  /// 程序要求 BarA 到 BarB 的渐变
  /// 我们处理成每个元素从 A 到 B 的渐变
  static Bar lerp(Bar begin, Bar end, double t) {
    // 送进来的 bgin 或 end 可能为空
    // 这种写法的副作用是, 不再以当前元素不存在时用 begin/end 的位置作动画起点
    // 而是直接变成了0, 所以会看到动画飞出来显示或飞向0消失
    return new Bar(
      lerpDouble(begin?.x, end?.x, t),
      lerpDouble(begin?.width, end?.width, t),
      lerpDouble(begin?.height, end?.height, t),
      Color.lerp((begin??end).color, (end??begin).color, t), // 这里的意思是, 颜色就不渐变了, 用结果/起始的对象的颜色
    );
  }
}

class BarTween extends Tween<Bar> {
  BarTween(Bar begin, Bar end) : super(begin: begin, end: end);

  @override
  Bar lerp(double t) => Bar.lerp(begin, end, t);
}

class BarChartVPainter extends CustomPainter {
  BarChartVPainter(Animation<BarChartV> animation)
      : animation = animation,
        super(repaint: animation);

  final Animation<BarChartV> animation;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = new Paint()..style = PaintingStyle.fill;
    final chart = animation.value;
    for (final bar in chart.bars) {
      paint.color = bar.color;
      final Rect rect = new Rect.fromLTWH(
          bar.x,
          size.height - bar.height,
          bar.width,
          bar.height,
        );
      canvas.drawRRect(
        new RRect.fromRectXY(rect, 5.0, 5.0),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(BarChartVPainter old) => false;
}