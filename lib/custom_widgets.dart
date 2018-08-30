import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'Custom/cover_flow.dart';
import 'main.dart';

class MyDemosPage extends StatelessWidget {
    final routes = [
      {
        "title": "Coverflow",
        "route": "/cust/coverflow",
        "widget": new MyCoverFlow()
      }
    ];
  MyDemosPage() {
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
          title: new Text('My Custom Widgets'),
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