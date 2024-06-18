import 'package:flut_base_app_the_movie_db_clone/app/ui/components/components.dart';
import 'package:flut_base_app_the_movie_db_clone/core/theme/theme.dart';
import 'package:flut_base_app_the_movie_db_clone/shared/shared.dart';
import 'package:flutter/material.dart';

class CustomBadge extends StatelessWidget {
  final double voteAverage;
  const CustomBadge({
    super.key,
    required this.voteAverage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: context.appColors.brandSecondary.black,
        borderRadius: context.radius.all.extraLarge,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text.rich(
            textAlign: TextAlign.start,
            TextSpan(
              children: [
                TextSpan(
                  text: ' ${voteAverage.convertToScore()}',
                  style: TextStyle(
                    color: context.appColors.brand.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                WidgetSpan(
                  child: Transform.translate(
                    offset: const Offset(0, -4),
                    child: BaseText(
                      text: '%',
                      color: context.appColors.brand.primary,
                      fontWeight: FontWeight.w700,
                      fontSize: 8,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 3,
            left: 3,
            right: 3,
            bottom: 3,
            child: CircularProgressIndicator(
              value: voteAverage / 10,
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                voteAverage.getScoreColor(),
              ),
              backgroundColor: voteAverage.getScoreColor().withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}
