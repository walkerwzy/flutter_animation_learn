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
      viewportFraction: 0.4,
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
    // Widget item = Container(
    //   margin: EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
    //   decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(10.0),
    //       color: Colors.green[p],
    //       boxShadow: [
    //         BoxShadow(
    //             color: Colors.grey, blurRadius: 7.0, offset: Offset(2.0, 2.0)),
    //       ]),
    //   child: Center(
    //       child: Text(
    //     "page $index",
    //   )),
    // );
    // Widget buildChild(double fraction) {
    //   print(fraction);
    //   return SizedBox(
    //       width: fraction * (constraints.maxWidth - 80),
    //       height: fraction * (constraints.maxHeight - 100),
    //       child: Container(
    //         // margin: EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
    //         decoration: BoxDecoration(
    //             borderRadius: BorderRadius.circular(10.0),
    //             color: Colors.green[p],
    //             boxShadow: [
    //               BoxShadow(
    //                   color: Colors.grey,
    //                   blurRadius: 7.0,
    //                   offset: Offset(2.0, 2.0)),
    //             ]),
    //         child: Center(
    //             child: Text(
    //           "page $index\n${fraction.toStringAsFixed(2)}",
    //         )),
    //       ));
    // }

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        var zoom = 1.0;
        if (controller.position.haveDimensions) {
          // print("page: ${controller.page}, index: $index");
          zoom = controller.page - index;
        } else {
          zoom = currentpage*1.0 - index;
        }
        zoom = (1 - zoom.abs() * .3).clamp(0.0, 1.0);
        var scale = Curves.easeOut.transform(zoom),
            height = scale * (constraints.maxHeight - 260),
            width = scale * (constraints.maxWidth*0.4-10);
        var log = """index: $index,
            value: $zoom,
            transform: ${scale.toStringAsFixed(2)},
            height: ${height.toStringAsFixed(2)}
            width: ${width.toStringAsFixed(2)}"""
            .replaceAll("\n", "")
            .replaceAll(" ", "");
        print(log);
        return Center(
          child: SizedBox(
              width: width,
              height: height,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 160.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.green[p],
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 7.0,
                          offset: Offset(2.0, 2.0)),
                    ]),
                child: Center(
                    child: Text(
                  "$index\n${scale.toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 50.0, color: Colors.white),
                )),
              )),
        );
      },
    );
    // child: item);
  }
}
