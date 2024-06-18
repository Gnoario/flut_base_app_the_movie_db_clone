import 'package:flut_base_app_the_movie_db_clone/app/ui/components/components.dart';
import 'package:flut_base_app_the_movie_db_clone/core/theme/theme.dart';
import 'package:flut_base_app_the_movie_db_clone/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBanner extends StatelessWidget {
  final String text;
  final String imagePath;
  final bool isSvg;
  final double? width;
  final double? height;

  const CustomBanner({
    super.key,
    required this.text,
    required this.imagePath,
    this.isSvg = false,
    this.width,
    this.height,
  });

  factory CustomBanner.error({
    required String text,
  }) {
    return CustomBanner(
      key: const Key('CustomBanner.error'),
      text: text,
      height: 180,
      imagePath: 'assets/svgs/warning.svg',
      isSvg: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isSvg)
          SvgPicture.asset(
            key: key,
            imagePath,
            width: width,
            height: height,
          )
        else
          Image.asset(
            imagePath,
            width: width,
            height: height,
          ),
        Flexible(
          child: Container(
            padding: context.spacer.all.xs,
            child: BaseText(
              text: text,
              color: context.appColors.brandSecondary.black,
              fontSize: 18,
              maxLines: 4,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
