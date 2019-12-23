import 'package:flutter/widgets.dart';

abstract class Flying {
  Size boundaries;
  Offset currentStartingPosition;
  Offset currentEndingPosition;
  Offset baseStartingPosition;
  Offset baseEndingPosition;
  void move();
}