import 'dart:async';

import 'package:digital_clock/src/node.dart';
import 'package:digital_clock/src/utils/clock_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DigitalSandClock extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => DigitalSandClockState();
}

class DigitalSandClockState extends State<DigitalSandClock> with TickerProviderStateMixin{

  DateTime _dateTime;
  AnimationController animationController;
  final nodeList = <Node>[];
  final numNodes = 20;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    _dateTime = DateTime.now();
    //_setTimer();
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
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Container(
          child: AnimatedBuilder(
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

  String _parseTimeFormat(int time) {
    if (time is int) {
      return time < 10 ? "0$time" : time.toString();
    } else {
      return "";
    }
  }

  void _setTimer() {
    _dateTime = DateTime.now();
    Timer(
      Duration(seconds: 1) - Duration(milliseconds: _dateTime.millisecond),
      _setTimer
    );
    setState(() {

    });
  }
}