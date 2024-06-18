import 'package:flut_base_app_the_movie_db_clone/app/data/repositories/repositories.dart';
import 'package:flut_base_app_the_movie_db_clone/app/domain/usecases/usecases.dart';
import 'package:flut_base_app_the_movie_db_clone/app/external/datasources/datasources.dart';
import 'package:flut_base_app_the_movie_db_clone/app/presentation/presenters/dasboard_presenter/dashboard_presenter_impl.dart';
import 'package:flut_base_app_the_movie_db_clone/app/presentation/presenters/list_movies_presenter/list_movies_presenter_impl.dart';
import 'package:flut_base_app_the_movie_db_clone/app/ui/pages/dashboard/dashboard_page.dart';
import 'package:flut_base_app_the_movie_db_clone/app/ui/pages/dashboard/dashboard_presenter.dart';
import 'package:flut_base_app_the_movie_db_clone/app/ui/pages/list_movies/list_movies_presenter.dart';
import 'package:flut_base_app_the_movie_db_clone/app/ui/pages/view_media/view_media_page.dart';
import 'package:flut_base_app_the_movie_db_clone/app/ui/pages/view_media/view_media_presenter.dart';
import 'package:flut_base_app_the_movie_db_clone/core/services/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../app/presentation/presenters/view_media_presenter/view_media_presenter_impl.dart';
import '../../app/ui/pages/list_movies/list_movies_page.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    //services
    i.addLazySingleton<ClientHttps>(() {
      return ClientHttps(
        interceptors: [
          ErrorHandleInterceptor(),
          HeadersInterceptors(),
          LoggersInterceptors(),
        ],
      );
    });

    //datasources
    i.addLazySingleton<GetMoviesDatasource>(GetMoviesImpDatasource.new);
    i.addLazySingleton<GetTrendingMediaDatasource>(
      GetTrendingMediaImpDatasource.new,
    );
    i.addLazySingleton<GetMediaCreditsDatasource>(
      GetMediaCreditsImpDatasource.new,
    );

    //repositories
    i.addLazySingleton<GetMoviesRepository>(
      GetMoviesImpRepository.new,
    );
    i.addLazySingleton<GetTrendingMediaRepository>(
      GetTrendingMediaImpRepository.new,
    );
    i.addLazySingleton<GetMediaCreditsRepository>(
      GetMediaCreditsImpRepository.new,
    );

    //usecases
    i.addLazySingleton<GetMoviesUsecase>(
      GetMoviesImpUsecase.new,
    );
    i.addLazySingleton<GetTrendingMediaUsecase>(
      GetTrendingMediaImpUsecase.new,
    );
    i.addLazySingleton<GetMediaCreditsUsecase>(
      GetMediaCreditsImpUsecase.new,
    );

    //presenters
    i.addLazySingleton<DashboardPresenter>(
      DashboardPresenterImpl.new,
      config: BindConfig(),
    );
    i.addLazySingleton<ListMoviesPresenter>(
      ListMoviesPresenterImpl.new,
      config: BindConfig(),
    );
    i.addLazySingleton<ViewMediaPresenter>(
      ViewMediaPresenterImpl.new,
      config: BindConfig(),
    );
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const DashboardPage());
    r.child(
      '/list-movies',
      child: (context) => ListMoviesPage(
        filter:
            kIsWeb ? r.args.queryParams['filter'] : r.args.data['movie_filter'],
        query: kIsWeb ? r.args.queryParams['query'] : r.args.data['query'],
      ),
    );
    r.child(
      '/view-media',
      child: (context) => ViewMediaPage(
        mediaItem: kIsWeb ? r.args.queryParams['media'] : r.args.data['media'],
      ),
    );
  }
}
