import 'package:flut_base_app_the_movie_db_clone/app/ui/components/components.dart';
import 'package:flut_base_app_the_movie_db_clone/core/theme/theme.dart';
import 'package:flut_base_app_the_movie_db_clone/shared/shared.dart';
import 'package:flutter/material.dart';

class SlidingCard extends StatelessWidget {
  final bool selected;
  final String text;
  const SlidingCard({
    super.key,
    required this.selected,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: selected
            ? context.appColors.brandSecondary.secondary
            : context.appColors.brand.primary,
        borderRadius: context.radius.all.medium,
      ),
      child: Center(
        child: BaseText(
            text: text,
            color: context.appColors.brandSecondary.secondary,
            fontWeight: FontWeight.w600,
            gradient: selected
                ? context.appColors.brandSecondary.gradientGreen
                : null),
      ),
    );
  }
}
