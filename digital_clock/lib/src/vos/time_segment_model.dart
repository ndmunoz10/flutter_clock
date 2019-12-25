import 'dart:async';
import 'package:flutter/widgets.dart';

enum PartOfDay {
  dawn, morning, noon, afterNoon, sunset, night
}

class TimeModel extends ChangeNotifier {
  DateTime _dateTime = DateTime.now();
  String _hour;
  String _minute;
  String _seconds;
  int _timePassedInSeconds;
  PartOfDay _partOfDay;

  TimeModel() {
    _setTimer();
  }

  String get hour => _hour;
  String get minute => _minute;
  String get seconds => _seconds;
  int get timePassedInSeconds => _timePassedInSeconds;
  PartOfDay get partOfDay => _partOfDay;

  void _updateHour() {
    _hour = _parseTimeFormat(_dateTime.hour);
    _minute = _parseTimeFormat(_dateTime.minute);
    _seconds = _parseTimeFormat(_dateTime.second);
    _getPartOfDay();
    DateTime subtractedDateTime = _dateTime.subtract(Duration(hours: isNight() ? 18 : 6));
    _timePassedInSeconds = (subtractedDateTime.hour * 60 * 60) + subtractedDateTime.minute * 60 + subtractedDateTime.second;
    notifyListeners();
  }

  void _getPartOfDay() {
    int _hour = _dateTime.hour;
    if (_hour > 6 && _hour <= 10) {
      _partOfDay = PartOfDay.morning;
    } else if (_hour > 10 && _hour <= 13) {
      _partOfDay = PartOfDay.noon;
    } else if (_hour > 13 && _hour <= 16) {
      _partOfDay = PartOfDay.afterNoon;
    } else if (_hour > 16 && _hour <= 18) {
      _partOfDay = PartOfDay.sunset;
    } else {
      _partOfDay = PartOfDay.night;
    }
  }

  bool isNight() => _partOfDay == PartOfDay.night;

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