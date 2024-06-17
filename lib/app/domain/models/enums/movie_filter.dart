import 'package:recase/recase.dart';

enum MovieFilter {
  popular,
  topRated,
  upcoming,
  nowPlaying,
}

extension EMovieFilter on MovieFilter {
  String get nameConstantCase => name.constantCase;
  String get nameSnakeCase => name.snakeCase;

  String get description {
    final action = {
      MovieFilter.popular: 'Populares',
      MovieFilter.topRated: 'Mais bem avaliados',
      MovieFilter.upcoming: 'Próximas estreias',
      MovieFilter.nowPlaying: 'Em cartaz',
    };

    return action[this] ?? 'Populares';
  }

  String get route {
    final action = {
      MovieFilter.popular: '/popular',
      MovieFilter.topRated: '/top-rated',
      MovieFilter.upcoming: '/upcoming',
      MovieFilter.nowPlaying: '/now-playing',
    };

    return action[this] ?? '/popular';
  }
}
