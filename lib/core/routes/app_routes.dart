import 'package:flut_base_app_the_movie_db_clone/app/domain/models/dtos/media_item/media_item_dto.dart';
import 'package:flut_base_app_the_movie_db_clone/app/domain/models/enums/enums.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppRoutes {
  static goToListMovies({
    MovieFilter? movieFilter,
    String? query,
  }) {
    final params = movieFilter != null
        ? '?filter=${movieFilter.nameSnakeCase}'
        : '?query=$query';
    return kIsWeb
        ? Modular.to.navigate('/list-movies$params')
        : Modular.to.pushNamed(
            '/list-movies',
            arguments: {
              'movie_filter': movieFilter,
              'query': query,
            },
          );
  }

  static goToViewMedia({
    required MediaItemDto media,
  }) {
    return kIsWeb
        ? Modular.to.navigate('/view-media', arguments: {
            'media': media,
          })
        : Modular.to.pushNamed(
            '/view-media',
            arguments: {
              'media': media,
            },
          );
  }

  static goToDashboard() {
    return kIsWeb ? Modular.to.navigate('/') : Modular.to.pushNamed('/');
  }

  static void pop<T extends Object>([T? result]) {
    if (result != null) {
      Modular.to.pop(result);
      return;
    }

    Modular.to.pop();
  }

  AppRoutes._();
}
