import 'package:animation2/Tween/useLerp.dart';
import 'package:animation2/Tween/useTween2.dart';
import 'package:animation2/Tween/useTweenObject.dart';
import 'package:animation2/Tween/useTweenObjectArray.dart';
import 'package:animation2/main.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class TweenHomePage extends StatelessWidget {
    final routes = [
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
    ];
  TweenHomePage() {
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
          title: new Text('Tween Home'),
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