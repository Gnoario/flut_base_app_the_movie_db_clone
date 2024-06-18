import 'package:flut_base_app_the_movie_db_clone/app/ui/components/components.dart';
import 'package:flut_base_app_the_movie_db_clone/core/theme/app_colors.dart';
import 'package:flut_base_app_the_movie_db_clone/shared/utils/dimensions.dart';
import 'package:flutter/material.dart';

class Toast {
  static void show(
    BuildContext context, {
    Duration duration = const Duration(seconds: 3),
    required String message,
    Color? backgroundColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: BaseText(
          text: message,
          color: context.appColors.brand.primary,
        ),
        backgroundColor: backgroundColor ?? context.appColors.neutral.grey3,
        duration: duration,
        margin: context.spacer.all.xxs,
        behavior: SnackBarBehavior.floating,
      ),
      snackBarAnimationStyle: AnimationStyle(
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 500),
        reverseCurve: Curves.easeInOut,
        reverseDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  static error(
    BuildContext context, {
    Duration duration = const Duration(seconds: 3),
    required String message,
  }) {
    return Toast.show(
      context,
      duration: duration,
      message: message,
      backgroundColor: context.appColors.brandSecondary.red,
    );
  }

  static success(
    BuildContext context, {
    Duration duration = const Duration(seconds: 3),
    required String message,
  }) {
    return Toast.show(
      context,
      duration: duration,
      message: message,
      backgroundColor: context.appColors.brandSecondary.green,
    );
  }
}
