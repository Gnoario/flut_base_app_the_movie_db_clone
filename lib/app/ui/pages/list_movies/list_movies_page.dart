import 'package:flut_base_app_the_movie_db_clone/app/domain/models/enums/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../components/components.dart';
import 'list_movies_presenter.dart';
import 'widgets/widgets.dart';

class ListMoviesPage extends StatefulWidget {
  final String? query;
  final MovieFilter? filter;
  const ListMoviesPage({
    super.key,
    this.query,
    this.filter,
  });

  @override
  createState() => _ListMoviesPageState();
}

class _ListMoviesPageState extends State<ListMoviesPage> {
  final presenter = Modular.get<ListMoviesPresenter>();
  String? query;
  MovieFilter? filter;
  final _focusNode = FocusNode();

  @override
  void initState() {
    query = widget.query;
    filter = widget.filter;
    presenter.startStreams();
    _getData();
    super.initState();
  }

  @override
  dispose() {
    presenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      currentRoute: '/list-movies',
      showDrawer: false,
      child: GestureDetector(
        onTap: () {
          _focusNode.unfocus();
        },
        child: Builder(
          builder: (context) {
            return SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (query != null)
                      SearchComponent(
                        focusNode: _focusNode,
                        initialValue: query,
                      ),
                    MovieList(
                      movieFilter: filter ?? MovieFilter.popular,
                      query: query,
                      onFilterChanged: (i) {
                        filter = MovieFilter.values[i];
                      },
                    ),
                    PaginationComponent(
                      filter: filter ?? MovieFilter.popular,
                      query: query,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _getData() {
    presenter
        .getMovies(
      page: 1,
      searchValue: query,
      movieFilter: filter ?? MovieFilter.popular,
    )
        .then((value) {
      if (!value.success) {
        Toast.error(
          context,
          message: value.message!,
        );
      }
    });
  }
}
