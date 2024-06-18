import 'package:flutter/material.dart';

extension DimensionExtension on BuildContext {
  Dimension get spacer => Dimension();
}

class Dimension {
  DimensionSize get top => DimensionSize.top();
  DimensionSize get bottom => DimensionSize.bottom();
  DimensionSize get left => DimensionSize.left();
  DimensionSize get right => DimensionSize.right();
  DimensionSize get x => DimensionSize.x();
  DimensionSize get y => DimensionSize.y();
  DimensionSize get all => DimensionSize.all();
  DimensionSizeValue get value => DimensionSizeValue();

  DimensionSize only({
    bool left = true,
    bool top = true,
    bool right = true,
    bool bottom = true,
  }) {
    return DimensionSize(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
    );
  }
}

class DimensionSizeValue {
  DimensionSizeValue();

  double get none => 0;
  double get xxxxs => 2;
  double get xxxs => 4;
  double get xxs => 8;
  double get xs => 8 * 2;
  double get sm => 8 * 3;
  double get md => 8 * 4;
  double get lg => 8 * 5;
  double get xl => 8 * 6;
  double get xxl => 8 * 7;
  double get xxxl => 8 * 8;
  double get xg => 8 * 9;
  double get xxg => 8 * 10;
  double get xxxg => 8 * 11;
}

class DimensionSize {
  final bool top;
  final bool left;
  final bool right;
  final bool bottom;
  final _value = DimensionSizeValue();

  DimensionSize({
    this.top = false,
    this.left = false,
    this.right = false,
    this.bottom = false,
  });
  factory DimensionSize.top() {
    return DimensionSize(top: true);
  }
  factory DimensionSize.left() {
    return DimensionSize(left: true);
  }
  factory DimensionSize.right() {
    return DimensionSize(right: true);
  }
  factory DimensionSize.bottom() {
    return DimensionSize(bottom: true);
  }
  factory DimensionSize.x() {
    return DimensionSize(right: true, left: true);
  }
  factory DimensionSize.y() {
    return DimensionSize(top: true, bottom: true);
  }
  factory DimensionSize.all() {
    return DimensionSize(top: true, bottom: true, right: true, left: true);
  }

  EdgeInsets get none => _getDimension(_value.none);
  EdgeInsets get xxxxs => _getDimension(_value.xxxxs);
  EdgeInsets get xxxs => _getDimension(_value.xxxs);
  EdgeInsets get xxs => _getDimension(_value.xxs);
  EdgeInsets get xs => _getDimension(_value.xs);
  EdgeInsets get sm => _getDimension(_value.sm);
  EdgeInsets get md => _getDimension(_value.md);
  EdgeInsets get lg => _getDimension(_value.lg);
  EdgeInsets get xl => _getDimension(_value.xl);
  EdgeInsets get xxl => _getDimension(_value.xxl);
  EdgeInsets get xxxl => _getDimension(_value.xxxl);
  EdgeInsets get xg => _getDimension(_value.xg);
  EdgeInsets get xxg => _getDimension(_value.xxg);
  EdgeInsets get xxxg => _getDimension(_value.xxxg);

  EdgeInsets _getDimension(double value) {
    return EdgeInsets.only(
      top: top ? value : 0,
      right: right ? value : 0,
      left: left ? value : 0,
      bottom: bottom ? value : 0,
    );
  }
}
