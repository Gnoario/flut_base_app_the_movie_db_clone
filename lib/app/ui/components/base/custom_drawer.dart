import 'package:flut_base_app_the_movie_db_clone/app/ui/components/base/menu_item.dart';
import 'package:flut_base_app_the_movie_db_clone/core/theme/theme.dart';
import 'package:flut_base_app_the_movie_db_clone/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool isExpanded = false;
  void toggleExpand() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.spacer.top.xxg,
      child: Drawer(
        elevation: 0,
        backgroundColor:
            context.appColors.brandSecondary.secondary.withOpacity(0.95),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        child: MenuItem(
          onTap: toggleExpand,
          isExpanded: isExpanded,
          currentRoute: Modular.to.path.split('/').last,
          title: 'Filmes',
        ),
      ),
    );
  }
}
