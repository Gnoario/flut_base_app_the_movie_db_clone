import 'package:recase/recase.dart';
import 'package:enum_to_string/enum_to_string.dart';

enum MediaType { tv, movie, person, unknown }

extension EMediaType on MediaType {
  String get nameConstantCase => name.constantCase;
  String get nameSnakeCase => name.snakeCase;

  String get description {
    final action = {
      MediaType.tv: 'Séries',
      MediaType.movie: 'Filmes',
      MediaType.person: 'Pessoas',
      MediaType.unknown: 'Desconhecido',
    };

    return action[this] ?? 'Desconhecido';
  }

  String get dynamicUrl {
    final action = {
      MediaType.tv: 'tv',
      MediaType.movie: 'movie',
      MediaType.person: 'person',
    };

    return action[this] ?? 'unknown';
  }

  static MediaType fromString(String value) {
    return EnumToString.fromString(MediaType.values, value) ??
        MediaType.unknown;
  }
}
