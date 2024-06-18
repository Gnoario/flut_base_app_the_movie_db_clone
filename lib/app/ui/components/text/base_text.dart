import 'package:flut_base_app_the_movie_db_clone/core/theme/theme.dart';
import 'package:flutter/material.dart';

class BaseText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextOverflow overflow;
  final int? maxLines;
  final TextStyle? style;
  final Gradient? gradient;
  const BaseText({
    super.key,
    required this.text,
    this.fontSize = 16,
    this.color,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow = TextOverflow.ellipsis,
    this.style,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: style ??
          baseStyle(context).copyWith(
            foreground: gradient != null
                ? (Paint()
                  ..shader = gradient?.createShader(
                    const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
                  ))
                : null,
          ),
    );
  }

  TextStyle baseStyle(BuildContext context) => TextStyle(
        overflow: overflow,
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color ?? context.appColors.brandSecondary.black,
      );
}
