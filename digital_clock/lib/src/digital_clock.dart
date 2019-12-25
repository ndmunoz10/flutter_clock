import 'dart:async';

import 'package:digital_clock/src/time_text.dart';
import 'package:digital_clock/src/utils/constants.dart';
import 'package:digital_clock/src/vos/decoration.dart';
import 'package:digital_clock/src/utils/clock_painter.dart';
import 'package:digital_clock/src/vos/shooting_star.dart';
import 'package:digital_clock/src/vos/time_segment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttie/fluttie.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:simple_animations/simple_animations/multi_track_tween.dart';

import 'vos/time_segment_model.dart';

class DigitalSandClock extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => DigitalSandClockState();
}

class DigitalSandClockState extends State<DigitalSandClock> with TickerProviderStateMixin{

  AnimationController _canvasAnimationController;
  FluttieAnimationController _lottieAnimation;
  final flyingList = <Flying>[];
  final numNodes = 3;
  final Fluttie _instance = Fluttie();
  bool _isBirdShowing = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimation();
    Timer.periodic(Duration(seconds: 5), _handleBirdVisibility);
  }

  @override
  void dispose() {
    _canvasAnimationController.dispose();
    _lottieAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _initializeNodeList(context, size);

    return Consumer<TimeModel>(
      builder: (context, timeModel, child) {
        MultiTrackTween tween = _getColorListBasedOnPartOfDay(timeModel);
        return ControlledAnimation(
          playback: Playback.MIRROR,
          tween: tween,
          duration: tween.duration,
          builder: (context, animation) => Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      animation[timeModel.partOfDay.toString() + "1"],
                      animation[timeModel.partOfDay.toString() + "2"]
                    ]
                )
            ),
            child: Stack(
              children: <Widget>[
                AnimatedBuilder(
                    animation: CurvedAnimation(
                        parent: _canvasAnimationController,
                        curve: Curves.easeInOut
                    ),
                    builder: (context, child) => CustomPaint(
                      painter: ClockPainter(
                          brightness: MediaQuery.of(context).platformBrightness,
                          flyingList: flyingList,
                          isNight: timeModel.isNight()
                      ),
                      size: size,
                    )
                ),
                Positioned(
                  top: size.height * 0.15,
                  right: (timeModel.timePassedInSeconds / SECONDS_12H) * (size.width - 130),
                  child: SvgPicture.asset(
                      "assets/images/${timeModel.isNight() ? "moon" : "sun"}.svg",
                      width: 130,
                      height: 130
                  ),
                ),
                AnimatedContainer(
                  alignment: _isBirdShowing ? Alignment.center : Alignment.bottomCenter,
                  child: AnimatedOpacity(
                    duration: Duration(milliseconds: 100),
                    child: FluttieAnimation(_lottieAnimation),
                    opacity: _isBirdShowing ? 1.0 : 0.0,
                  ),
                  duration: Duration(seconds: 1),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Consumer<TimeModel>(
                      builder: (context, timeModel, child) => Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          TimeText(
                            timeText: timeModel.hour,
                            fontSize: 144,
                            fontWeight: FontWeight.bold,
                            textAlign: TextAlign.end,
                          ),
                          TimeText(
                            timeText: timeModel.minute,
                            fontSize: 89,
                            fontWeight: FontWeight.normal,
                            textAlign: TextAlign.end,
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _initializeNodeList(BuildContext context, Size size) {
    flyingList.clear();
    final flyingStarStart = ShootingStar(
        boundaries: size,
      currentStartingPosition: size.topLeft(Offset(size.width * 0.2, size.height * 0.1)),
      currentEndingPosition: size.topLeft(Offset(size.width * 0.17, size.height * 0.15))
    );
    final flyingStarCenter = ShootingStar(
        boundaries: size,
        currentStartingPosition: size.topCenter(Offset(0, size.height * 0.3)),
        currentEndingPosition: size.topCenter(Offset(-25, size.height * 0.35))
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

  MultiTrackTween _getColorListBasedOnPartOfDay(TimeModel timeModel) {
    PartOfDay _partOfDay = timeModel.partOfDay;
    switch(_partOfDay) {
      case PartOfDay.morning:
        return MultiTrackTween([
          Track(_partOfDay.toString() + "1").add(Duration(seconds: 1),
              ColorTween(begin: Color(0xff009dd3), end: Color(0xff58d5d3))),
          Track(_partOfDay.toString() + "2").add(Duration(seconds: 1),
              ColorTween(begin: Color(0xff87bbfa), end: Color(0xff87b1fa))),
        ]);
      case PartOfDay.noon:
        return MultiTrackTween([
          Track(_partOfDay.toString() + "1").add(Duration(seconds: 1),
              ColorTween(begin: Color(0xff87bbfa), end: Color(0xff87b1fa))),
          Track(_partOfDay.toString() + "2").add(Duration(seconds: 1),
              ColorTween(begin: Color(0xfffcfb99), end: Color(0xfffebd46))),
        ]);
      case PartOfDay.afterNoon:
        return MultiTrackTween([
          Track(_partOfDay.toString() + "1").add(Duration(seconds: 1),
              ColorTween(begin: Color(0xfffcfb99), end: Color(0xfffebd46))),
          Track(_partOfDay.toString() + "2").add(Duration(seconds: 1),
              ColorTween(begin: Color(0xfffc9c54), end: Color(0xfffd5e53))),
        ]);
      case PartOfDay.sunset:
        return MultiTrackTween([
          Track(_partOfDay.toString() + "1").add(Duration(seconds: 1),
              ColorTween(begin: Color(0xfffc9c54), end: Color(0xfffd5e53))),
          Track(_partOfDay.toString() + "2").add(Duration(seconds: 1),
              ColorTween(begin: Color(0xff4b3d60), end: Color(0xff3c314d))),
        ]);
      default :
        return MultiTrackTween([
          Track(_partOfDay.toString() + "1").add(Duration(seconds: 1),
              ColorTween(begin: Color(0xff4b3d60), end: Color(0xff3c314d))),
          Track(_partOfDay.toString() + "2").add(Duration(seconds: 1),
              ColorTween(begin: Color(0xff08183a), end: Color(0xff152852))),
        ]);
    }
  }

  void _initializeAnimation() async {
    _canvasAnimationController = new AnimationController(vsync: this, duration: new Duration(seconds: 1))
      ..addListener(() {
        flyingList.forEach((flying) {
          flying.move();
        });
      })
      ..repeat();
    var _animation = await _instance.loadAnimationFromAsset(
      "assets/animations/bird_animation.json",
    );
    _lottieAnimation = await _instance.prepareAnimation(
        _animation,
        repeatCount: RepeatCount.infinite(),
        duration: Duration(seconds: 2)
    );
    _lottieAnimation.start();
  }

  void _handleBirdVisibility(Timer timer) {
    setState(() {
      _isBirdShowing = true;
    });
    Timer(Duration(seconds: 2), () => setState(() {_isBirdShowing = false;}));
  }
}