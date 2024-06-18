import 'package:flut_base_app_the_movie_db_clone/app/ui/components/components.dart';
import 'package:flut_base_app_the_movie_db_clone/app/ui/pages/list_movies/list_movies_presenter.dart';
import 'package:flut_base_app_the_movie_db_clone/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SearchComponent extends StatefulWidget {
  final String? initialValue;
  final FocusNode focusNode;

  const SearchComponent({
    super.key,
    this.initialValue,
    required this.focusNode,
  });

  @override
  State<SearchComponent> createState() => _SearchComponentState();
}

class _SearchComponentState extends State<SearchComponent> {
  String _query = '';
  final presenter = Modular.get<ListMoviesPresenter>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.spacer.x.xs + context.spacer.top.xs,
      child: SizedBox(
        height: 50,
        child: BasicField(
          labelText: 'Buscar por filmes...',
          initialValue: widget.initialValue,
          focusNode: widget.focusNode,
          showBorder: true,
          onChanged: (v) {
            _query = v ?? '';
          },
          onTapButton: () {
            if (_query.isNotEmpty) {
              presenter.getMovies(
                page: 1,
                searchValue: _query,
              );
            }
          },
          onFieldSubmitted: (v) {
            if (v?.isNotEmpty == true) {
              presenter.getMovies(
                page: 1,
                searchValue: v,
              );
            }
          },
        ),
      ),
    );
  }
}
