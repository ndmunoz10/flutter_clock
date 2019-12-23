import 'package:digital_clock/src/vos/decoration.dart';
import 'package:flutter/cupertino.dart';

class ShootingStar implements Flying {

  @override
  Size boundaries;
  @override
  Offset currentStartingPosition;
  @override
  Offset currentEndingPosition;
  @override
  Offset baseStartingPosition;
  @override
  Offset baseEndingPosition;

  ShootingStar({
    @required this.boundaries,
    @required this.currentStartingPosition,
    @required this.currentEndingPosition
  }) {
    baseStartingPosition = currentStartingPosition;
    baseEndingPosition = currentEndingPosition;
}

  @override
  void move() {
    currentStartingPosition -= new Offset(8.0, -8.0);
    currentEndingPosition -= new Offset(8.0, -8.0);
    if (!boundaries.contains(currentStartingPosition) &&
    !boundaries.contains(currentEndingPosition)) {
      currentStartingPosition = baseStartingPosition;
      currentEndingPosition = baseEndingPosition;
    }
  }
}