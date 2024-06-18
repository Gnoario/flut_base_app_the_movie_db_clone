import 'package:flut_base_app_the_movie_db_clone/app/ui/components/base/custom_drawer.dart';
import 'package:flut_base_app_the_movie_db_clone/core/routes/app_routes.dart';
import 'package:flut_base_app_the_movie_db_clone/core/theme/theme.dart';
import 'package:flut_base_app_the_movie_db_clone/shared/shared.dart';
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
          centerTitle: true,
          iconTheme: IconThemeData(color: context.appColors.brand.primary),
          title: ImageAsset.squareLogo(),
          backgroundColor: context.appColors.brandSecondary.secondary,
          leading: !showDrawer
              ? IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    AppRoutes.pop();
                  },
                )
              : null,
        ),
        body: child,
      ),
    );
  }
}
