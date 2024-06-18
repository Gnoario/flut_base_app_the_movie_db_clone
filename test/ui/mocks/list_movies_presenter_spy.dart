import 'dart:async';

import 'package:flut_base_app_the_movie_db_clone/app/domain/models/dtos/pagination/pagination_dto.dart';
import 'package:flut_base_app_the_movie_db_clone/app/domain/models/enums/enums.dart';
import 'package:flut_base_app_the_movie_db_clone/app/domain/presentation/result_presentation.dart';
import 'package:flut_base_app_the_movie_db_clone/app/ui/components/components.dart';
import 'package:flut_base_app_the_movie_db_clone/app/ui/pages/list_movies/list_movies_presenter.dart';
import 'package:mockito/mockito.dart';

class ListMoviesPresenterSpy extends Mock implements ListMoviesPresenter {
  bool getMoviesCalled = false;

  @override
  Stream<bool> get isGetMoviesLoading =>
      _isGetMoviesLoadingController.stream.asBroadcastStream();

  @override
  Stream<ResultPresentation> get movies =>
      _moviesController.stream.asBroadcastStream();

  @override
  Stream<PaginationDto> get pagination =>
      _paginationController.stream.asBroadcastStream();

  @override
  PaginationDto? currentPage = PaginationDto(page: 1);

  @override
  PaginationController? paginationController = PaginationController();

  final StreamController<bool> _isGetMoviesLoadingController =
      StreamController<bool>.broadcast();

  final StreamController<ResultPresentation> _moviesController =
      StreamController<ResultPresentation>.broadcast();

  final StreamController<PaginationDto> _paginationController =
      StreamController<PaginationDto>.broadcast();

  @override
  Future<ResultPresentation> getMovies({
    required int page,
    String? searchValue,
    MovieFilter movieFilter = MovieFilter.popular,
  }) {
    getMoviesCalled = true;
    return super.noSuchMethod(Invocation.method(#getMovies, []),
        returnValue: Future.value(), returnValueForMissingStub: Future.value());
  }

  emitMovies(ResultPresentation result) {
    _moviesController.add(result);
  }

  emitPagination(PaginationDto pagination) {
    _paginationController.add(pagination);
  }

  emitIsGetMoviesLoading(bool isLoading) {
    _isGetMoviesLoadingController.add(isLoading);
  }

  @override
  void dispose() {
    _moviesController.close();
    _paginationController.close();
    _isGetMoviesLoadingController.close();
  }
}
