import 'package:flut_base_app_the_movie_db_clone/app/domain/models/enums/enums.dart';
import 'package:flut_base_app_the_movie_db_clone/app/ui/components/base/custom_drawer.dart';
import 'package:flut_base_app_the_movie_db_clone/app/ui/components/components.dart';
import 'package:flut_base_app_the_movie_db_clone/core/routes/app_routes.dart';
import 'package:flut_base_app_the_movie_db_clone/core/theme/theme.dart';
import 'package:flut_base_app_the_movie_db_clone/shared/shared.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BasePage extends StatelessWidget {
  final Widget child;
  final String currentRoute;
  final bool showDrawer;
  const BasePage({
    super.key,
    required this.child,
    required this.currentRoute,
    this.showDrawer = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: context.appColors.brand.primary,
        drawerScrimColor: Colors.transparent,
        drawer: isResponsiveMode(context) && showDrawer
            ? const CustomDrawer()
            : null,
        appBar: AppBar(
          centerTitle: isResponsiveMode(context) ? true : false,
          iconTheme: IconThemeData(color: context.appColors.brand.primary),
          title: isResponsiveMode(context)
              ? ImageAsset.squareLogo()
              : Row(
                  children: [
                    ImageAsset.shortLogo(
                      width: 100,
                    ),
                    SizedBox(width: context.spacer.value.xs),
                    if (showDrawer)
                      CustomDropdownButton(
                        items: MovieFilter.values
                            .map((e) => e.description)
                            .toList(),
                        onChanged: (v) {
                          final index = MovieFilter.values.indexWhere(
                              (element) => element.description == v);
                          if (index != -1) {
                            AppRoutes.goToListMovies(
                              movieFilter: MovieFilter.values[index],
                            );
                          }
                        },
                      ),
                  ],
                ),
          backgroundColor: context.appColors.brandSecondary.secondary,
          leading: !showDrawer
              ? IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    kIsWeb ? AppRoutes.goToDashboard() : AppRoutes.pop();
                  },
                )
              : null,
        ),
        body: child,
      ),
    );
  }
}
