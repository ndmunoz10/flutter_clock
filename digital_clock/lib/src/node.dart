import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

enum Direction {
  LEFT,
  RIGHT,
  TOP,
  BOTTOM,
  TOP_LEFT,
  TOP_RIGHT,
  BOTTOM_LEFT,
  BOTTOM_RIGHT
}

class Node {
  int id;
  Size screenSize;
  double radius;
  double size;
  Offset position;
  Direction direction;
  Random random;

  Map<int, Node> connected;

  Node(
      {@required this.id,
        this.size,
        this.radius = 200.0,
        @required this.screenSize}) {
    random = new Random();
    size = (2 + random.nextInt(7)).toDouble();
    connected = new Map();
    position = screenSize.center(Offset.zero);
    direction = Direction.values[random.nextInt(Direction.values.length)];
  }

  void move(double seed) {
    switch (direction) {
      case Direction.LEFT:
        position -= new Offset(1.0 + seed, 0.0);
        if (position.dx <= 5.0) {
          List<Direction> dirAvailableList = [
            Direction.RIGHT,
            Direction.BOTTOM_RIGHT,
            Direction.TOP_RIGHT
          ];
          direction = dirAvailableList[random.nextInt(dirAvailableList.length)];
          size = (2 + random.nextInt(7)).toDouble();
        }

        break;
      case Direction.RIGHT:
        position += new Offset(1.0 + seed, 0.0);
        if (position.dx >= screenSize.width - 5.0) {
          List<Direction> dirAvailableList = [
            Direction.LEFT,
            Direction.BOTTOM_LEFT,
            Direction.TOP_LEFT
          ];
          direction = dirAvailableList[random.nextInt(dirAvailableList.length)];
          size = (2 + random.nextInt(7)).toDouble();
        }
        break;
      case Direction.TOP:
        position -= new Offset(0.0, 1.0 + seed);
        if (position.dy <= 5.0) {
          List<Direction> dirAvailableList = [
            Direction.BOTTOM,
            Direction.BOTTOM_LEFT,
            Direction.BOTTOM_RIGHT
          ];
          direction = dirAvailableList[random.nextInt(dirAvailableList.length)];
          size = (2 + random.nextInt(7)).toDouble();
        }
        break;
      case Direction.BOTTOM:
        position += new Offset(0.0, 1.0 + seed);
        if (position.dy >= screenSize.height - 5.0) {
          List<Direction> dirAvailableList = [
            Direction.TOP,
            Direction.TOP_LEFT,
            Direction.TOP_RIGHT,
          ];
          direction = dirAvailableList[random.nextInt(dirAvailableList.length)];
          size = (2 + random.nextInt(7)).toDouble();
        }
        break;
      case Direction.TOP_LEFT:
        position -= new Offset(1.0 + seed, 1.0 + seed);
        if (position.dx <= 5.0 || position.dy <= 5.0) {
          List<Direction> dirAvailableList = [
            Direction.BOTTOM_RIGHT,
          ];

          //if y invalid and x valid
          if (position.dy <= 5.0 && position.dx > 5.0) {
            dirAvailableList.add(Direction.LEFT);
            dirAvailableList.add(Direction.RIGHT);
            dirAvailableList.add(Direction.BOTTOM);
            dirAvailableList.add(Direction.BOTTOM_LEFT);
          }
          //if x invalid and y valid
          if (position.dx <= 5.0 && position.dy > 5.0) {
            dirAvailableList.add(Direction.TOP);
            dirAvailableList.add(Direction.RIGHT);
            dirAvailableList.add(Direction.BOTTOM);
            dirAvailableList.add(Direction.TOP_RIGHT);
          }
          direction = dirAvailableList[random.nextInt(dirAvailableList.length)];
          size = (2 + random.nextInt(7)).toDouble();
        }
        break;
      case Direction.TOP_RIGHT:
        position -= new Offset(-1.0 - seed, 1.0 + seed);
        if (position.dx >= screenSize.width - 5.0 || position.dy <= 5.0) {
          List<Direction> dirAvailableList = [
            Direction.BOTTOM_LEFT,
          ];

          //if y invalid and x valid
          if (position.dy <= 5.0 && position.dx < screenSize.width - 5.0) {
            dirAvailableList.add(Direction.LEFT);
            dirAvailableList.add(Direction.RIGHT);
            dirAvailableList.add(Direction.BOTTOM);
            dirAvailableList.add(Direction.BOTTOM_RIGHT);
          }
          //if x invalid and y valid
          if (position.dx >= screenSize.width - 5.0 && position.dy > 5.0) {
            dirAvailableList.add(Direction.TOP);
            dirAvailableList.add(Direction.BOTTOM);
            dirAvailableList.add(Direction.LEFT);
            dirAvailableList.add(Direction.TOP_LEFT);
          }
          direction = dirAvailableList[random.nextInt(dirAvailableList.length)];
          size = (2 + random.nextInt(7)).toDouble();
        }
        break;
      case Direction.BOTTOM_LEFT:
        position -= new Offset(1.0 + seed, -1.0 + seed);
        if (position.dx <= 5.0 || position.dy >= screenSize.height - 5.0) {
          List<Direction> dirAvailableList = [
            Direction.TOP_RIGHT,
          ];
          //if y invalid and x valid
          if (position.dy >= screenSize.height - 5.0 && position.dx > 5.0) {
            dirAvailableList.add(Direction.LEFT);
            dirAvailableList.add(Direction.RIGHT);
            dirAvailableList.add(Direction.TOP);
            dirAvailableList.add(Direction.TOP_LEFT);
          }
          //if x invalid and y valid
          if (position.dx <= 5.0 && position.dy < screenSize.height - 5.0) {
            dirAvailableList.add(Direction.TOP);
            dirAvailableList.add(Direction.BOTTOM);
            dirAvailableList.add(Direction.RIGHT);
            dirAvailableList.add(Direction.BOTTOM_RIGHT);
          }
          direction = dirAvailableList[random.nextInt(dirAvailableList.length)];
          size = (2 + random.nextInt(7)).toDouble();
        }
        break;
      case Direction.BOTTOM_RIGHT:
        position += new Offset(1.0 + seed, 1.0 + seed);
        if (position.dx >= screenSize.width - 5.0 ||
            position.dy >= screenSize.height - 5.0) {
          List<Direction> dirAvailableList = [
            Direction.TOP_LEFT,
          ];
          //if y invalid and x valid
          if (position.dy >= screenSize.height - 5.0 &&
              position.dx < screenSize.width - 5.0) {
            dirAvailableList.add(Direction.LEFT);
            dirAvailableList.add(Direction.RIGHT);
            dirAvailableList.add(Direction.TOP);
            dirAvailableList.add(Direction.TOP_RIGHT);
          }
          //if x invalid and y valid
          if (position.dx >= screenSize.width - 5.0 &&
              position.dy < screenSize.height - 5.0) {
            dirAvailableList.add(Direction.TOP);
            dirAvailableList.add(Direction.BOTTOM);
            dirAvailableList.add(Direction.LEFT);
            dirAvailableList.add(Direction.BOTTOM_LEFT);
          }
          direction = dirAvailableList[random.nextInt(dirAvailableList.length)];
          size = (2 + random.nextInt(7)).toDouble();
        }
        break;
    }
  }

  void changeNodeSize() {
    size = (10 + random.nextInt(50)).toDouble();
  }

  bool canConnect(Node node) {
    double x = node.position.dx - position.dx;
    double y = node.position.dy - position.dy;
    double d = x * x + y * y;
    return d <= radius * radius;
  }

  void connect(Node node) {
    if (canConnect(node)) {
      if (!node.connected.containsKey(id)) {
        connected.putIfAbsent(node.id, () => node);
      }
    } else if (connected.containsKey(node.id)) {
      connected.remove(node.id);
    }
  }

  bool operator ==(o) => o is Node && o.id == id;

  int get hashCode => id;
}