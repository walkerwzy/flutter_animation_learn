import 'dart:math' as math;
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import 'animatedBuilder.dart';
import 'animatedWidgets.dart';
import 'basic.dart';

class AnimateDemoPage extends StatelessWidget {
  final routes = [
      {"title": "basic", "route": "/basic", "widget": new LogoApp()},
      {
        "title": "Custom AnimateWidget",
        "route": "/a_widgets",
        "widget": new AnimatedWidgetsDemo()
      },
      {
        "title": "AnimatedBuilder",
        "route": "/a_builder",
        "widget": new Logo2App()
      },
      {
        "title": "AnimatedSize",
        "route": "/a_widget_exist/0",
        "widget": new ExistAnimateWidgateDemo(type: 0,)
      },
      {
        "title": "AnimatedContainer",
        "route": "/a_widget_exist/1",
        "widget": new ExistAnimateWidgateDemo(type: 1,)
      },
      {
        "title": "TransformWidget",
        "route": "/a_widget_exist/2",
        "widget": new ExistAnimateWidgateDemo(type: 2,)
      },
  ];
  AnimateDemoPage() {
      routes.forEach((Map<String, Object> m) {
      var route = m["route"], widget = m["widget"];
      Application.router.define(route, handler: new Handler(handlerFunc:
          (BuildContext context, Map<String, List<String>> params) {
        return widget;
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('Animation Home'),
        ),
        body: ListView.builder(
          itemCount: this.routes.length,
          itemBuilder: (c, i) {
            var item = this.routes[i];
            return ListTile(
              title: Text(item["title"]),
              onTap: () {
                Application.router.navigateTo(context, item["route"],
                    transition: TransitionType.native);
              },
            );
          },
        ));
  }
}

class ExistAnimateWidgateDemo extends StatefulWidget {
  ExistAnimateWidgateDemo({this.type}) : super();
  final type;
  final titles = ["AnimatedSize", "AnimatedContainer", "TransformWidget"];
  @override
  _ExistAnimateWidgateDemoState createState() => new _ExistAnimateWidgateDemoState();
}

class _ExistAnimateWidgateDemoState extends State<ExistAnimateWidgateDemo>
    with SingleTickerProviderStateMixin {
  double measure1;

  @override
  void initState() {
    measure1 = 10.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
            // Here we take t
            title: new Text(widget.titles[widget.type]),
        ),
        body: Builder(builder: (c) {
          switch (widget.type) {
              case 0:
                return createAnimatedSize();
                break;
                case 1:
                return createAnimatedContainer();
                break;
                case 2:
              default:
              return createTransformWidget();
            }
        }),
        floatingActionButton: new FloatingActionButton(
          onPressed: () {
            measure1 += 30;
            if (measure1 > 300) measure1 = 10.0;
            setState(() {});
          },
          tooltip: 'Increment',
          child: new Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  AnimatedSize createAnimatedSize() {
    return new AnimatedSize(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
      child:
          //  new DecoratedBox(child: new SizedBox(height: measure1, width: measure1),
          //  decoration: new BoxDecoration(color: Colors.blue[200]),
          //  ),
          // 这个元素变大了, 它会用一个动画把容器撑大
          // 但是元素自己是直接变大的
          new Text(
        "aa bb cc",
        style: new TextStyle(fontSize: measure1 * 5),
      ),
    );
  }

  AnimatedContainer createAnimatedContainer() {
    //  以下构造函数的属性, 只要变更, 这个 container 就会以动画形式变更到目标状态
    return new AnimatedContainer(
      constraints: BoxConstraints.tightFor(width: measure1, height: 143.0),
      decoration: const BoxDecoration(color: const Color(0xFF00FF00)),
      foregroundDecoration: const BoxDecoration(color: const Color(0x7F0000FF)),
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(7.0),
      // transform: new Matrix4.translationValues(4.0, measure1, 0.0),
      // transform: new Matrix4.rotationY(math.pi/measure1*10.0),
      // width: measure1,
      // height: 75.0,
      curve: Curves.ease,
      duration: const Duration(milliseconds: 200),
      child: Text("Animate Container"),
    );
  }

  Widget createTransformWidget() {
    final transform = new Transform(
      alignment: Alignment.topRight,
      transform: new Matrix4.skewY(0.3)..rotateZ(-math.pi / 12.0),
      child: new Container(
        padding: const EdgeInsets.all(8.0),
        color: const Color(0xFFE8581C),
        child: const Text('Apartment for rent!'),
      ),
    );
    // return transform;
    return new Container(
      color: Colors.black,
      child: transform,
    );
  }
}