import 'package:flut_base_app_the_movie_db_clone/app/domain/models/enums/enums.dart';
import 'package:flut_base_app_the_movie_db_clone/core/routes/app_routes.dart';
import 'package:flut_base_app_the_movie_db_clone/core/theme/theme.dart';
import 'package:flut_base_app_the_movie_db_clone/shared/shared.dart';
import 'package:flutter/material.dart';

import '../components.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final Function() onTap;
  final bool isExpanded;
  final String? currentRoute;

  const MenuItem({
    super.key,
    required this.title,
    required this.onTap,
    this.isExpanded = false,
    this.currentRoute,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.spacer.left.xs + context.spacer.top.xs,
      child: ExpandableButton(
        isExpanded: isExpanded,
        onTap: onTap,
        title: title,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: MovieFilter.values
                .map(
                  (filter) => Flexible(
                    child: Padding(
                      padding: context.spacer.y.xxxs,
                      child: NavigationButton(
                        title: filter.description,
                        onTap: () => AppRoutes.goToListMovies(
                          movieFilter: filter,
                        ),
                        color: selectedColor(filter.route, context),
                      ),
                    ),
                  ),
                )
                .toList()),
      ),
    );
  }

  Color selectedColor(String route, BuildContext context) =>
      route == currentRoute
          ? context.appColors.brandSecondary.greyBlue
          : context.appColors.brand.primary;
}
