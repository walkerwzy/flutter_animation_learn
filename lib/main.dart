import 'package:animation2/someWidegts.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'basic.dart';
import 'animatedWidgets.dart';
import 'animatedBuilder.dart';
import 'useLerp.dart';
import 'useTweenObject.dart';
import 'useTween2.dart';
import 'useTweenObjectArray.dart';

class Application {
  static Router router;
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
      {"title": "basic", "route": "/basic", "widget": new LogoApp()},
      {
        "title": "use animated widgets",
        "route": "/a_widgets",
        "widget": new AnimatedWidgetsDemo()
      },
      {
        "title": "use animated builder",
        "route": "/a_builder",
        "widget": new Logo2App()
      },
      {
        "title": "use lerp_double gen interplolate",
        "route": "/bar_lerp",
        "widget": new ChartPage()
      },
      {
        "title": "use tween gen interplolate",
        "route": "/bar_tween",
        "widget": new ChartPageTween()
      },
      {
        "title": "use tween object",
        "route": "/bar_tween_object",
        "widget": new TweenChartPage()
      },
      {
        "title": "use obj array to tween",
        "route": "/bar_array_tween",
        "widget": new ChartPageArray()
      },
      {
        "title": "some animated widgets demo",
        "route": "/demo_animated_widgets",
        "widget": new AnimateWidgateDemoPage()
      },
      // {
      //   "title": "animated widgets demo",
      //   "route": "/demo_animated_widgets/:id",
      //   "widget": new AnimateWidgateDemo()
      // }
    ];
    Application.router = new Router();
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
