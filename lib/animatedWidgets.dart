import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

// demo of AnimatedWidgets
// 把控件提取为响应 Animation 的 value 的控件

void main() => runApp(new AnimatedWidgetsDemo());

class AnimatedLogo extends AnimatedWidget {
  AnimatedLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    var body = new Center(
      child: new Container(
        margin: new EdgeInsets.symmetric(vertical: 10.0),
        height: animation.value,
        width: animation.value,
        child: new FlutterLogo(),
      ),
    );
    return new Scaffold(
      appBar: new AppBar(title: new Text("Animated Widgets"),),
      body: body,
    );
  }
}

class AnimatedWidgetsDemo extends StatefulWidget {
  @override
  _AnimatedWidgetsDemoState createState() => new _AnimatedWidgetsDemoState();
}

class _AnimatedWidgetsDemoState extends State<AnimatedWidgetsDemo> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = new Tween(begin: 0.0, end: 300.0).animate(controller)
    ..addStatusListener((status){
      if(status == AnimationStatus.completed) {
        controller.reverse();
      }else if(status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) => new AnimatedLogo(animation: animation);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
