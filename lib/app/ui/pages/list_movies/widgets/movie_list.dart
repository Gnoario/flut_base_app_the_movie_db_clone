import 'package:flut_base_app_the_movie_db_clone/app/domain/models/enums/enums.dart';
import 'package:flut_base_app_the_movie_db_clone/app/ui/pages/list_movies/list_movies_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../domain/presentation/result_presentation.dart';
import '../../../components/components.dart';

class MovieList extends StatefulWidget {
  final MovieFilter movieFilter;
  final String? query;
  final ValueChanged<int>? onFilterChanged;
  const MovieList({
    super.key,
    this.movieFilter = MovieFilter.popular,
    this.query,
    this.onFilterChanged,
  });

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  int groupValue = 0;
  final presenter = Modular.get<ListMoviesPresenter>();
  @override
  void initState() {
    super.initState();
    setState(() {
      groupValue = MovieFilter.values.indexOf(widget.movieFilter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: presenter.isGetMoviesLoading,
      initialData: true,
      builder: (context, snapshot) {
        bool isLoading = snapshot.data ?? false;
        return StreamBuilder<ResultPresentation>(
          stream: presenter.movies,
          builder: (context, snapshot) {
            final getMoviesResult = snapshot.data;

            return VerticalListView.fromMediaList(
              context: context,
              error: getMoviesResult?.message,
              media: getMoviesResult?.payload ?? [],
              isLoading: isLoading,
              header: widget.query != null
                  ? const BaseHeader(title: 'Filmes')
                  : BaseHeader.headerWithFilter(
                      context: context,
                      initialValue: widget.movieFilter.description,
                      isLoading: isLoading,
                      title: 'Filmes',
                      groupValue: groupValue,
                      children: MovieFilter.values
                          .map(
                            (filter) => filter.description,
                          )
                          .toList(),
                      onValueChanged: (i) {
                        if (i != null && i != groupValue) {
                          presenter.getMovies(
                            page: 1,
                            searchValue: widget.query,
                            movieFilter: MovieFilter.values[i],
                          );
                          setState(() {
                            groupValue = i;
                          });
                          widget.onFilterChanged?.call(i);
                        }
                      },
                    ),
            );
          },
        );
      },
    );
  }
}
