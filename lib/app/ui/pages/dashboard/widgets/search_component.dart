import 'package:flut_base_app_the_movie_db_clone/app/ui/components/card/search_card.dart';
import 'package:flut_base_app_the_movie_db_clone/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../dashboard_presenter.dart';

class SearchComponent extends StatefulWidget {
  final FocusNode focusNode;
  const SearchComponent({
    super.key,
    required this.focusNode,
  });

  @override
  State<SearchComponent> createState() => _SearchComponentState();
}

class _SearchComponentState extends State<SearchComponent> {
  String _query = '';
  final presenter = Modular.get<DashboardPresenter>();
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: presenter.randomMediaBackgroundPath,
      builder: (context, snapshot) {
        final bannerPath = snapshot.data;
        return SearchCard(
          controller: searchController,
          bannerPath: bannerPath,
          focusNode: widget.focusNode,
          onFieldSubmitted: (query) async {
            widget.focusNode.unfocus();
            Future.delayed(const Duration(milliseconds: 300));
            if (query?.isNotEmpty == true && searchController.text.isNotEmpty) {
              AppRoutes.goToListMovies(query: query);
            }
          },
          onTapButton: () async {
            widget.focusNode.unfocus();
            Future.delayed(const Duration(milliseconds: 300));
            if (_query.isNotEmpty && searchController.text.isNotEmpty) {
              AppRoutes.goToListMovies(query: _query);
            }
          },
          onChanged: (v) {
            _query = v ?? '';
          },
        );
      },
    );
  }
}
