import 'package:flut_base_app_the_movie_db_clone/app/domain/models/dtos/pagination/pagination_dto.dart';
import 'package:flut_base_app_the_movie_db_clone/app/domain/models/enums/enums.dart';
import 'package:flut_base_app_the_movie_db_clone/app/domain/presentation/result_presentation.dart';
import 'package:flut_base_app_the_movie_db_clone/app/ui/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

abstract class ListMoviesPresenter implements Disposable, Listenable {
  Stream<bool> get isGetMoviesLoading;
  Stream<ResultPresentation> get movies;
  Stream<PaginationDto> get pagination;
  PaginationDto? currentPage;
  PaginationController? paginationController;

  startStreams();
  Future<ResultPresentation> getMovies({
    required int page,
    String? searchValue,
    MovieFilter movieFilter = MovieFilter.popular,
  });
}
