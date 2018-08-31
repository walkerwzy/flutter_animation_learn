import 'package:flutter/material.dart';
import 'dart:math';

class MyCoverFlow extends StatefulWidget {
  @override
  MyCoverFlowState createState() {
    return new MyCoverFlowState();
  }
}

class MyCoverFlowState extends State<MyCoverFlow> {
  PageController controller;
  int currentpage = 0;

  @override
  initState() {
    super.initState();
    controller = new PageController(
      initialPage: currentpage,
      keepPage: false,
      viewportFraction: 0.8,
    );
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Scaffold(
          appBar: AppBar(title: Text("Cover Flow")),
          body: PageView.builder(
            itemCount: 5,
            onPageChanged: (i) {
              currentpage = i;
            },
            controller: controller,
            itemBuilder: (c, i) => builder(i, constraints),
          ),
        );
      },
    );
  }

  Widget builder(int index, BoxConstraints constraints) {
    int p = index * 100 + 100;
    p = min(p, 800);
    Widget item = Container(
      margin: EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.green[p],
          boxShadow: [
            BoxShadow(
                color: Colors.grey, blurRadius: 7.0, offset: Offset(2.0, 2.0)),
          ]),
      child: Center(
          child: Text(
        "page $index",
      )),
    );
    return SafeArea(
        bottom: true,
        child: AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              var zoom = 1.0;
              if (controller.position.haveDimensions) {
                // print("page: ${controller.page}, index: $index");
                zoom = controller.page - index;
                zoom = (1 - zoom.abs() * .5).clamp(0.0, 1.0);
              }
              print("transform: ${Curves.easeOut.transform(zoom)}, $constraints");
              return SizedBox(
                width: Curves.easeOut.transform(zoom) * 300,// (constraints.maxWidth-20),
                height: Curves.easeOut.transform(zoom) * 200,//(constraints.maxHeight-100),
                child: item,
              );
            },
            child: item));
  }
}
