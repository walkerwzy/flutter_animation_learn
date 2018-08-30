import 'package:animation2/custom_widgets.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'Basic/someWidegts.dart';
import 'tween_home.dart';

class Application {
  static Router router = Router();
}

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  MyAppState() {
    final routes = [
      {
        "title": "Basic Animation",
        "route": "/demo_animated_widgets",
        "widget": new AnimateDemoPage()
      },
      {
        "title": "Use Tween",
        "route": "/tween",
        "widget": new TweenHomePage(),
      },
      {
        "title": "Custom Home",
        "route": "/cust",
        "widget": new MyDemosPage()
      },
    ];
    Application.router.define("/", handler: new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new HomeWidgets(
        routes: routes,
      );
    }));
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
    return MaterialApp(
      title: "Animation Demo",
      onGenerateRoute: Application.router.generator,
    );
  }
}

class HomeWidgets extends StatelessWidget {
  HomeWidgets({@required this.routes}) : super();
  final List<Map<String, Object>> routes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('Home'),
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
