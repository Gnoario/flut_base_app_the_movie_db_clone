import 'package:flut_base_app_the_movie_db_clone/app/domain/models/enums/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../domain/presentation/result_presentation.dart';
import '../../../components/components.dart';
import '../dashboard_presenter.dart';

class MovieList extends StatefulWidget {
  const MovieList({super.key});

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  int groupValue = 0;
  final presenter = Modular.get<DashboardPresenter>();
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

            return HorizontalListView.fromMediaList(
              context: context,
              error: getMoviesResult?.message,
              media: getMoviesResult?.payload ?? [],
              isLoading: isLoading,
              header: BaseHeader.headerWithFilter(
                context: context,
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
                      movieFilter: MovieFilter.values[i],
                    );
                    setState(() {
                      groupValue = i;
                    });
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
