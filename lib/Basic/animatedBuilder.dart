import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

// demo use of AnimatedBuilder
// 控件保持原始, build 里面使用Animation值

class Logo2Widget extends StatelessWidget {
  // Leave out the height and width so it fills the animating parent
  build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.symmetric(vertical: 10.0),
      child: new FlutterLogo(),
    );
  }
}

class GrowTransition extends StatelessWidget {
  GrowTransition({this.child, this.animation});

  final Widget child;
  final Animation<double> animation;

  Widget build(BuildContext context) {
    return new Center(
      child: new AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget child) {
            return new Container(
                height: animation.value, width: animation.value, child: child);
          },
          child: child),
    );
  }
}

class Logo2App extends StatefulWidget {
  _Logo2AppState createState() => new _Logo2AppState();
}

class _Logo2AppState extends State<Logo2App> with TickerProviderStateMixin {
  Animation animation;
  AnimationController controller;

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    final CurvedAnimation curve =
        new CurvedAnimation(parent: controller, curve: Curves.easeIn);
    animation = new Tween(begin: 0.0, end: 300.0).animate(curve)
     ..addStatusListener((status){
      if(status == AnimationStatus.completed) {
        controller.reverse();
      }else if(status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    controller.forward();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Animated Builder"),),
      body: new GrowTransition(child: new Logo2Widget(), animation: animation),
    );
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}

void main() {
  runApp(new Logo2App());
}