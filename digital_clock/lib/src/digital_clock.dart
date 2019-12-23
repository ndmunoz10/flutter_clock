import 'package:digital_clock/src/time_text.dart';
import 'package:digital_clock/src/utils/constants.dart';
import 'package:digital_clock/src/vos/decoration.dart';
import 'package:digital_clock/src/utils/clock_painter.dart';
import 'package:digital_clock/src/vos/shooting_star.dart';
import 'package:digital_clock/src/vos/time_segment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'vos/time_segment_model.dart';

class DigitalSandClock extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => DigitalSandClockState();
}

class DigitalSandClockState extends State<DigitalSandClock> with TickerProviderStateMixin{

  AnimationController canvasAnimationController;
  final flyingList = <Flying>[];
  final numNodes = 3;

  @override
  void initState() {
    super.initState();
    _initializeAnimation();
  }

  @override
  void dispose() {
    canvasAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    size.width;
    _initializeNodeList(context, size);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [
              0.1,
              0.4,
              0.6,
              0.9
            ],
            colors: [
              Color(0xff00003f),
              Color(0xff00003f),
              Color(0xff00003f),
              Color(0xff00003f)
            ]
          )
        ),
        child: Stack(
          children: <Widget>[
            AnimatedBuilder(
                animation: CurvedAnimation(
                    parent: canvasAnimationController,
                    curve: Curves.easeInOut
                ),
                builder: (context, child) => CustomPaint(
                  painter: ClockPainter(
                      brightness: MediaQuery.of(context).platformBrightness,
                      flyingList: flyingList
                  ),
                  size: size,
                )
            ),
            Consumer<TimeModel>(
                builder: (context, timeModel, child) => Positioned(
                  top: size.height * 0.15,
                  right: (timeModel.timePassed / SECONDS_12H) * (size.width - 100),
                  child: SvgPicture.asset(
                      "assets/images/moon.svg",
                      width: 100,
                      height: 100
                  ),
                )
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    TimeText(
                      isHour: true,
                    ),
                    TimeText(
                      isHour: false,
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _initializeNodeList(BuildContext context, Size size) {
    flyingList.clear();
    final flyingStarStart = ShootingStar(
        boundaries: size,
      currentStartingPosition: size.topLeft(Offset(size.width * 0.2, size.height * 0.1)),
      currentEndingPosition: size.topLeft(Offset(size.width * 0.15, size.height * 0.15))
    );
    final flyingStarCenter = ShootingStar(
        boundaries: size,
        currentStartingPosition: size.topCenter(Offset(0, size.height * 0.3)),
        currentEndingPosition: size.topCenter(Offset(-30, size.height * 0.35))
    );
    final flyingStarEnd = ShootingStar(
        boundaries: size,
        currentStartingPosition: size.topRight(Offset(-size.width * 0.2, size.height * 0.2)),
        currentEndingPosition: size.topRight(Offset(-size.width * 0.23, size.height * 0.25))
    );
    flyingList..add(flyingStarStart)
    ..add(flyingStarCenter)
    ..add(flyingStarEnd);
  }

  void _initializeAnimation() {
    canvasAnimationController = new AnimationController(vsync: this, duration: new Duration(seconds: 1))
      ..addListener(() {
        flyingList.forEach((flying) {
          flying.move();
        });
      })
      ..repeat();
  }
}