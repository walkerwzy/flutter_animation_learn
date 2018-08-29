import 'package:flutter/material.dart';
import 'dart:math' as math;

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       title: 'Flutter Demo',
//       theme: new ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: new WidgetDemoPage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

class AnimateWidgateDemoPage extends StatelessWidget {
  final tabs = [
    "AnimatedSize",
    "AnimatedContainer",
    "TrnsformWidget"
  ];
  @override
  Widget build(BuildContext context){
    return Scaffold(appBar: AppBar(title: Text('Animated Widgets',)),
    body: ListView.builder(itemCount: tabs.length,
    itemBuilder: (c, i) {
      return ListTile(title: Text(tabs[i]));
    },)
    );
  }
}

// class AnimateWidgateDemo extends StatefulWidget {
//   AnimateWidgateDemo({@required this.tabs}) : super()
//   final List<String> tabs;
//   @override
//   _AnimateWidgateDemoState createState() => new _AnimateWidgateDemoState();
// }

// class _AnimateWidgateDemoState extends State<AnimateWidgateDemo>
//     with SingleTickerProviderStateMixin {
//   double measure1;

//   @override
//   void initState() {
//     measure1 = 10.0;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: tabs.length,
//       initialIndex: 0,
//       child: Scaffold(
//         appBar: new AppBar(
//             // Here we take t
//             title: new Text("Animated Widgets"),
//             bottom: TabBar(
//               tabs: tabs.map((m) {
//                 return Tab(
//                   text: m,
//                 );
//               }).toList(),
//             )),
//         body: TabBarView(
//           children: tabs.map((m) {
//             final index = tabs.indexOf(m);
//             switch (index) {
//               case 0:
//                 return createAnimatedSize();
//                 break;
//                 case 1:
//                 return createAnimatedContainer();
//                 break;
//                 case 2:
//               default:
//               return createTransformWidget();
//             }
//           }).toList(),
//         ),
//         floatingActionButton: new FloatingActionButton(
//           onPressed: () {
//             measure1 += 30;
//             if (measure1 > 300) measure1 = 10.0;
//             setState(() {});
//           },
//           tooltip: 'Increment',
//           child: new Icon(Icons.add),
//         ), // This trailing comma makes auto-formatting nicer for build methods.
//       ),
//     );
//   }

//   AnimatedSize createAnimatedSize() {
//     return new AnimatedSize(
//       duration: const Duration(milliseconds: 1000),
//       vsync: this,
//       child:
//           //  new DecoratedBox(child: new SizedBox(height: measure1, width: measure1),
//           //  decoration: new BoxDecoration(color: Colors.blue[200]),
//           //  ),
//           // 这个元素变大了, 它会用一个动画把容器撑大
//           // 但是元素自己是直接变大的
//           new Text(
//         "aa bb cc",
//         style: new TextStyle(fontSize: measure1 * 5),
//       ),
//     );
//   }

//   AnimatedContainer createAnimatedContainer() {
//     //  以下构造函数的属性, 只要变更, 这个 container 就会以动画形式变更到目标状态
//     return new AnimatedContainer(
//       constraints: BoxConstraints.tightFor(width: measure1, height: 143.0),
//       decoration: const BoxDecoration(color: const Color(0xFF00FF00)),
//       foregroundDecoration: const BoxDecoration(color: const Color(0x7F0000FF)),
//       margin: const EdgeInsets.all(10.0),
//       padding: const EdgeInsets.all(7.0),
//       // transform: new Matrix4.translationValues(4.0, measure1, 0.0),
//       transform: new Matrix4.rotationX(9.0),
//       width: 300.0,
//       height: 75.0,
//       curve: Curves.ease,
//       duration: const Duration(milliseconds: 200),
//     );
//   }

//   Widget createTransformWidget() {
//     final transform = new Transform(
//       alignment: Alignment.topRight,
//       transform: new Matrix4.skewY(0.3)..rotateZ(-math.pi / 12.0),
//       child: new Container(
//         padding: const EdgeInsets.all(8.0),
//         color: const Color(0xFFE8581C),
//         child: const Text('Apartment for rent!'),
//       ),
//     );
//     // return transform;
//     return new Container(
//       color: Colors.black,
//       child: transform,
//     );
//   }
// }
