import 'package:flut_base_app_the_movie_db_clone/app/ui/components/components.dart';
import 'package:flut_base_app_the_movie_db_clone/core/theme/theme.dart';
import 'package:flut_base_app_the_movie_db_clone/shared/shared.dart';
import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  final String title;
  final Function() onTap;
  final Color? color;

  const NavigationButton({
    super.key,
    required this.title,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: context.spacer.x.xxxs,
        child: BaseText(
          text: title,
          color: color ?? context.appColors.brand.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
