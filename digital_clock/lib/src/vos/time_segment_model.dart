import 'dart:async';
import 'package:digital_clock/src/utils/constants.dart';
import 'package:flutter/widgets.dart';

class TimeModel extends ChangeNotifier {
  DateTime _dateTime = DateTime.now();
  String _hour;
  String _minute;
  int _timePassedInSeconds;

  TimeModel() {
    _setTimer();
  }

  String get hour => _hour;
  String get minute => _minute;
  int get timePassed => _timePassedInSeconds;

  void _updateHour() {
    _hour = _parseTimeFormat(_dateTime.hour);
    _minute = _parseTimeFormat(_dateTime.minute);
    DateTime subtractedDateTime = _dateTime.subtract(Duration(hours: _dateTime.hour >= 18 || _dateTime.hour <= 6 ? 18 : 6));
    _timePassedInSeconds = (subtractedDateTime.hour * 60 * 60) + subtractedDateTime.minute * 60 + subtractedDateTime.second;
    print(_timePassedInSeconds);
    notifyListeners();
  }

  void _setTimer() {
    _dateTime = DateTime.now();
    _updateHour();
    Timer(
        Duration(seconds: 1) - Duration(milliseconds: _dateTime.millisecond),
        _setTimer
    );
  }

  String _parseTimeFormat(int time) {
    if (time is int) {
      String _formattedTime = time < 10 ? "0$time" : time.toString();
      return "$_formattedTime";
    } else {
      return "";
    }
  }
}