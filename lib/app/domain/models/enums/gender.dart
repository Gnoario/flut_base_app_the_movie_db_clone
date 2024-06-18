import 'package:recase/recase.dart';

enum Gender {
  female,
  male,
}

extension EGender on Gender {
  String get nameConstantCase => name.constantCase;
  String get nameSnakeCase => name.snakeCase;

  String get description {
    final action = {
      Gender.male: 'Homem',
      Gender.female: 'Mulher',
    };

    return action[this] ?? '';
  }

  static Gender fromInt(int? value) {
    final action = {
      1: Gender.male,
      2: Gender.female,
    };

    return action[value] ?? Gender.male;
  }
}
