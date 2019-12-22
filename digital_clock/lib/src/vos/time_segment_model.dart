import 'dart:async';

import 'package:flutter/widgets.dart';

class TimeModel extends ChangeNotifier {
  DateTime _dateTime = DateTime.now();
  String _hour;
  String _minute;

  TimeModel() {
    _setTimer();
  }

  String get hour => _hour;
  String get minute => _minute;

  void _updateHour() {
    _hour = _parseTimeFormat(_dateTime.hour);
    _minute = _parseTimeFormat(_dateTime.minute);
    notifyListeners();
  }

  void _setTimer() {
    _dateTime = DateTime.now();
    _updateHour();
    Timer(
        Duration(minutes: 1) -
            Duration(seconds: _dateTime.second) -
            Duration(milliseconds: _dateTime.millisecond),
        _setTimer
    );
  }

  String _parseTimeFormat(int time) {
    if (time is int) {
      String _formattedHours = time < 10 ? "0$time" : time.toString();
      return "$_formattedHours";
    } else {
      return "";
    }
  }
}