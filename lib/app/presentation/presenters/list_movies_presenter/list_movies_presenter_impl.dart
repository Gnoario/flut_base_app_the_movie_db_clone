import 'dart:async';
import 'dart:ui';

import 'package:flut_base_app_the_movie_db_clone/app/domain/models/dtos/pagination/pagination_dto.dart';
import 'package:flut_base_app_the_movie_db_clone/app/domain/presentation/result_presentation.dart';
import 'package:flut_base_app_the_movie_db_clone/app/domain/usecases/get_movies/get_movies_usecase.dart';
import 'package:flut_base_app_the_movie_db_clone/app/ui/components/pagination/pagination_controller.dart';

import '../../../domain/models/enums/enums.dart';
import '../../../domain/models/exceptions/exceptions.dart';
import '../../../ui/pages/list_movies/list_movies_presenter.dart';

class ListMoviesPresenterImpl implements ListMoviesPresenter {
  final GetMoviesUsecase _getMoviesUsecase;

  ListMoviesPresenterImpl(this._getMoviesUsecase);

  late StreamController<ResultPresentation> _moviesController;

  late StreamController<PaginationDto> _paginationController;

  late StreamController<bool> _isGetMoviesLoadingController;

  @override
  PaginationDto? currentPage = PaginationDto(page: 1);

  @override
  Stream<bool> get isGetMoviesLoading => _isGetMoviesLoadingController.stream;

  @override
  Stream<ResultPresentation> get movies => _moviesController.stream;

  @override
  @override
  Stream<PaginationDto> get pagination => _paginationController.stream;

  @override
  void addListener(VoidCallback listener) {}

  @override
  void dispose() {
    _moviesController.close();
    _paginationController.close();
    _isGetMoviesLoadingController.close();
  }

  @override
  startStreams() {
    _moviesController = StreamController<ResultPresentation>.broadcast();
    _paginationController = StreamController<PaginationDto>.broadcast();
    _isGetMoviesLoadingController = StreamController<bool>.broadcast();
  }

  @override
  Future<ResultPresentation> getMovies({
    required int page,
    String? searchValue,
    MovieFilter movieFilter = MovieFilter.popular,
  }) async {
    try {
      _isGetMoviesLoadingController.add(true);
      final pagination = currentPage!.copyWith(
        page: page,
      );
      _paginationController.add(pagination);
      final result = await _getMoviesUsecase(
        pagination: pagination,
        movieFilter: movieFilter,
        searchValue: searchValue,
      );
      if (currentPage?.totalPages != result.pagination.totalPages) {
        currentPage = result.pagination;
      }
      _paginationController.add(result.pagination);
      final resultPresentation = ResultPresentation(
        payload: result.media,
      );
      _moviesController.add(resultPresentation);
      return resultPresentation;
    } on HandledException catch (e) {
      final resultPresentation = ResultPresentation.exception(e);
      _moviesController.add(resultPresentation);
      return resultPresentation;
    } finally {
      _isGetMoviesLoadingController.add(false);
    }
  }

  @override
  void removeListener(VoidCallback listener) {}

  @override
  PaginationController? paginationController = PaginationController();
}
