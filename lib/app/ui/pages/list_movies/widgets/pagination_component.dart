import 'package:flut_base_app_the_movie_db_clone/app/domain/models/enums/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../domain/models/dtos/pagination/pagination_dto.dart';
import '../../../components/components.dart';
import '../list_movies_presenter.dart';

class PaginationComponent extends StatelessWidget {
  final MovieFilter filter;
  final String? query;
  const PaginationComponent({
    super.key,
    this.filter = MovieFilter.popular,
    this.query,
  });

  @override
  Widget build(BuildContext context) {
    final presenter = Modular.get<ListMoviesPresenter>();
    return StreamBuilder<PaginationDto>(
      stream: presenter.pagination,
      builder: (context, snapshot) {
        final pagination = snapshot.data;
        return Pagination(
          controller: presenter.paginationController,
          page: presenter.currentPage?.page ?? 1,
          total:
              pagination?.totalPages ?? presenter.currentPage?.totalPages ?? 0,
          onChanged: (i) {
            presenter.getMovies(
              page: i,
              searchValue: query,
              movieFilter: filter,
            );
          },
        );
      },
    );
  }
}
