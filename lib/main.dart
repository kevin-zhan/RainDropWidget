import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

import 'rain_drop.dart';
void main() {
  debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rain Drop',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Rain Drop Anim'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{

  List<RainDropDrawer> rainList;
  final GlobalKey paintKey = GlobalKey();
  AnimationController animation;

  @override
  void initState() {
    super.initState();
    rainList = List();
    animation = new AnimationController(
      // 这个动画应该持续的时间长短
        duration: const Duration(milliseconds: 500),
        vsync: this
    )..addListener(() {
      if(rainList.isEmpty) {
        animation.stop();
      }
      setState(() {

      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          color: Colors.lightBlueAccent,
          child: GestureDetector(
            key: paintKey,
            onTapUp: (TapUpDetails tapUp) {
              RenderBox getBox = paintKey.currentContext.findRenderObject();
              var localOffset = getBox.globalToLocal(tapUp.globalPosition);

              var rainDrop = RainDropDrawer(localOffset.dx, localOffset.dy);
              rainList.add(rainDrop);
              animation.repeat();
            },
            child: CustomPaint(
              painter: RainDrop(rainList),
              size: Size(300, 300),
            ),
          ),
        )
        ),
      );
  }
}
