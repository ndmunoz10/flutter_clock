import 'dart:async';
import 'package:flutter/widgets.dart';

class TimeModel extends ChangeNotifier {
  DateTime _dateTime = DateTime.now();
  String _hour;
  String _minute;
  String _seconds;
  int _timePassedInSeconds;
  bool _isNight;

  TimeModel() {
    _setTimer();
  }

  String get hour => _hour;
  String get minute => _minute;
  String get seconds => _seconds;
  int get timePassed => _timePassedInSeconds;
  bool get isNight => _isNight;

  void _updateHour() {
    _hour = _parseTimeFormat(_dateTime.hour);
    _minute = _parseTimeFormat(_dateTime.minute);
    _seconds = _parseTimeFormat(_dateTime.second);
    if (_dateTime.hour >= 18 || _dateTime.hour <= 6) {
      _isNight = true;
    } else {
      _isNight = false;
    }
    DateTime subtractedDateTime = _dateTime.subtract(Duration(hours: isNight ? 18 : 6));
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