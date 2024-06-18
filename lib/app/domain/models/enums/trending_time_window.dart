import 'package:recase/recase.dart';

enum TrendingTimeWindow { day, week }

extension ETrendingTimeWindow on TrendingTimeWindow {
  String get nameConstantCase => name.constantCase;
  String get nameSnakeCase => name.snakeCase;

  String get description {
    final action = {
      TrendingTimeWindow.day: 'Hoje',
      TrendingTimeWindow.week: 'Nesta semana',
    };

    return action[this] ?? '';
  }
}
