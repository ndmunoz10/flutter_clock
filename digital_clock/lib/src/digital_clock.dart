import 'package:digital_clock/src/time_text.dart';
import 'package:digital_clock/src/node.dart';
import 'package:digital_clock/src/utils/clock_painter.dart';
import 'package:digital_clock/src/vos/time_segment_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DigitalSandClock extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => DigitalSandClockState();
}

class DigitalSandClockState extends State<DigitalSandClock> with TickerProviderStateMixin{

  AnimationController animationController;
  final nodeList = <Node>[];
  final numNodes = 20;

  @override
  void initState() {
    super.initState();
    _initializeAnimation();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _initializeNodeList(context, size);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        child: Stack(
          children: <Widget>[
            AnimatedBuilder(
                animation: CurvedAnimation(
                    parent: animationController,
                    curve: Curves.easeInOut
                ),
                builder: (context, child) => CustomPaint(
                  painter: ClockPainter(
                      brightness: MediaQuery.of(context).platformBrightness,
                      nodeList: nodeList
                  ),
                  size: size,
                )
            ),
            ChangeNotifierProvider(
              create: (context) => TimeModel(),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Flexible(
                          flex: 5,
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: TimeText(
                                isHour: true,
                              )
                          ),
                        ),
                        Flexible(
                          flex: 5,
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: TimeText(
                                isHour: false,
                              )
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _initializeNodeList(BuildContext context, Size size) {
    nodeList.clear();
    new List.generate(numNodes, (i) {
      nodeList.add(new Node(id: i, screenSize: size));
    });
  }

  void _initializeAnimation() {
    animationController = new AnimationController(vsync: this, duration: new Duration(seconds: 20))
      ..addListener(() {
        for (int i = 0; i < nodeList.length; i++) {
          nodeList[i].move(animationController.value);
          for (int j = i + 1; j < nodeList.length; j++) {
            nodeList[i].connect(nodeList[j]);
          }
        }
      })
      ..repeat();
  }
}