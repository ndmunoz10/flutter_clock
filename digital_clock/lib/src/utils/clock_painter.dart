import 'package:digital_clock/src/node.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ClockPainter extends CustomPainter {

  final List<Node> nodeList;
  final Brightness brightness;

  ClockPainter({
    @required this.nodeList,
    @required this.brightness
  });

  void draw(Node parentNode, Canvas canvas, Paint circlePaint, Paint linePaint) {
    canvas.drawCircle(parentNode.position, parentNode.size, circlePaint);

    parentNode.connected.forEach((id, node) {
      canvas.drawLine(parentNode.position, node.position, linePaint);
    });
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint circlePaint = Paint()
      ..strokeWidth = 4
      ..color = Colors.deepOrange
      ..style = PaintingStyle.fill;

    Paint linePaint = Paint()
      ..strokeWidth = 0.5
      ..color = brightness == Brightness.light ? Color(0xff000000) : Color(0xffffffff)
      ..style = PaintingStyle.stroke;

    for (var node in nodeList) {
      draw(node, canvas, circlePaint, linePaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}