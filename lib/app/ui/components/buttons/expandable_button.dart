import 'package:flut_base_app_the_movie_db_clone/app/ui/components/components.dart';
import 'package:flut_base_app_the_movie_db_clone/core/theme/theme.dart';
import 'package:flut_base_app_the_movie_db_clone/shared/shared.dart';
import 'package:flutter/material.dart';

class ExpandableButton extends StatelessWidget {
  final bool isExpanded;
  final Function() onTap;
  final String title;
  final Color? color;
  final Widget child;
  const ExpandableButton({
    super.key,
    required this.isExpanded,
    required this.onTap,
    required this.title,
    this.color,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: context.radius.all.small,
          child: Padding(
            padding: context.spacer.x.xxxs,
            child: BaseText(
              text: title,
              color: context.appColors.brand.primary,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: isExpanded ? 200 : 0,
            child: child,
          ),
        ),
      ],
    );
  }
}
