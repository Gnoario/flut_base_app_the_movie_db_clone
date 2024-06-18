import 'package:flutter/material.dart';

extension RadiusUtilsExtension on BuildContext {
  RadiusUtils get radius => RadiusUtils();
}

class RadiusUtils {
  RadiusSize get top => RadiusSize.top();
  RadiusSize get bottom => RadiusSize.bottom();
  RadiusSize get topLeft => RadiusSize.topLeft();
  RadiusSize get topRight => RadiusSize.topRight();
  RadiusSize get bottomRight => RadiusSize.bottomRight();
  RadiusSize get bottomLeft => RadiusSize.bottomLeft();
  RadiusSize get left => RadiusSize.left();
  RadiusSize get right => RadiusSize.right();
  RadiusSize get all => RadiusSize.all();
  RadiusSizeValue get value => RadiusSizeValue();

  RadiusSize only({
    bool left = true,
    bool top = true,
    bool right = true,
    bool bottom = true,
  }) {
    return RadiusSize(
      bottomLeft: left,
      topLeft: top,
      topRight: right,
      bottomRight: bottom,
    );
  }
}

class RadiusSizeValue {
  RadiusSizeValue();
  double get zero => 0;
  double get small => 2;
  double get medium => 8;
  double get large => 12;
  double get extraLarge => 40;
}

class RadiusSize {
  final bool topLeft;
  final bool bottomLeft;
  final bool topRight;
  final bool bottomRight;
  final _value = RadiusSizeValue();

  RadiusSize({
    this.topLeft = false,
    this.bottomLeft = false,
    this.topRight = false,
    this.bottomRight = false,
  });
  factory RadiusSize.topLeft() {
    return RadiusSize(topLeft: true);
  }
  factory RadiusSize.bottomLeft() {
    return RadiusSize(bottomLeft: true);
  }
  factory RadiusSize.topRight() {
    return RadiusSize(topRight: true);
  }
  factory RadiusSize.bottomRight() {
    return RadiusSize(bottomRight: true);
  }
  factory RadiusSize.top() {
    return RadiusSize(topLeft: true, topRight: true);
  }
  factory RadiusSize.bottom() {
    return RadiusSize(bottomLeft: true, bottomRight: true);
  }

  factory RadiusSize.left() {
    return RadiusSize(topLeft: true, bottomLeft: true);
  }

  factory RadiusSize.right() {
    return RadiusSize(topRight: true, bottomRight: true);
  }

  factory RadiusSize.all() {
    return RadiusSize(
      topLeft: true,
      bottomRight: true,
      topRight: true,
      bottomLeft: true,
    );
  }

  BorderRadius get zero => _getRadius(_value.zero);
  BorderRadius get small => _getRadius(_value.small);
  BorderRadius get medium => _getRadius(_value.medium);
  BorderRadius get large => _getRadius(_value.large);
  BorderRadius get extraLarge => _getRadius(_value.extraLarge);

  BorderRadius _getRadius(double value) {
    return BorderRadius.only(
      topLeft: Radius.circular(topLeft ? value : 0),
      topRight: Radius.circular(topRight ? value : 0),
      bottomLeft: Radius.circular(bottomLeft ? value : 0),
      bottomRight: Radius.circular(bottomRight ? value : 0),
    );
  }
}
