import 'dart:ui';
import 'package:digital_clock/src/vos/decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ClockPainter extends CustomPainter {

  final List<Flying> flyingList;
  final Brightness brightness;

  ClockPainter({
    @required this.flyingList,
    @required this.brightness
  });

  void _drawStaticStars(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final pointMode = PointMode.points;
    final List<Offset> points = [
      Offset(width * 0.2, height * 0.2),
      Offset(width * 0.2, height * 0.6),
      Offset(width * 0.3, height * 0.7),
      Offset(width * 0.4, height * 0.2),
      Offset(width * 0.3, height * 0.8),
      Offset(width * 0.2, height * 0.9),
      Offset(width * 0.3, height * 0.3),
      Offset(width * 0.6, height * 0.5),
      Offset(width * 0.8, height * 0.7),
      Offset(width * 0.9, height * 0.9),
      Offset(width * 0.9, height * 0.1),
      Offset(width * 0.8, height * 0.3),
      Offset(width * 0.8, height * 0.4),
      Offset(width * 0.7, height * 0.3),
      Offset(width * 0.5, height * 0.5),
      Offset(width * 0.3, height * 0.4)
    ];
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(pointMode, points, paint);
  }

  void _drawFlyingElements(Canvas canvas) {
    Paint paint = Paint()
      ..strokeWidth = 3
      ..color = Colors.white
      ..style = PaintingStyle.stroke;
    for (var flying in flyingList) {
      canvas.drawLine(flying.currentStartingPosition, flying.currentEndingPosition, paint);
    }
  }

  @override
  void paint(Canvas canvas, Size size) async {
    _drawStaticStars(canvas, size);
    _drawFlyingElements(canvas);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}