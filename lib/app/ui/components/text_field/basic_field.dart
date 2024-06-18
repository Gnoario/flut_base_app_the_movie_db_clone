import 'package:flut_base_app_the_movie_db_clone/app/ui/components/components.dart';
import 'package:flut_base_app_the_movie_db_clone/core/theme/theme.dart';
import 'package:flut_base_app_the_movie_db_clone/shared/shared.dart';
import 'package:flutter/material.dart';

class BasicField extends StatelessWidget {
  final Function(String?) onFieldSubmitted;
  final Function(String?) onChanged;
  final Function() onTapButton;
  final String labelText;
  final FocusNode? focusNode;
  final String? initialValue;
  final bool showBorder;
  final TextEditingController? controller;

  const BasicField({
    super.key,
    required this.onFieldSubmitted,
    required this.labelText,
    required this.onChanged,
    required this.onTapButton,
    this.focusNode,
    this.initialValue,
    this.showBorder = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      focusNode: focusNode,
      controller: controller ??
          TextEditingController(
            text: initialValue,
          ),
      autofocus: false,
      style: TextStyle(color: context.appColors.neutral.grey3, fontSize: 14),
      decoration: InputDecoration(
        filled: true,
        fillColor: context.appColors.brand.primary,
        labelText: labelText,
        labelStyle: TextStyle(
          color: context.appColors.neutral.grey3,
        ),
        border: _defaultBorder(context),
        focusedBorder: _defaultBorder(context),
        enabledBorder: _defaultBorder(context),
        suffixIcon: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: context.radius.all.extraLarge,
            gradient: context.appColors.brandSecondary.searchGradient,
          ),
          child: ElevatedButton(
            onPressed: onTapButton,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: context.radius.all.extraLarge,
              ),
            ).merge(
              ButtonStyle(
                elevation: WidgetStateProperty.all(0),
              ),
            ),
            child: BaseText(
              text: 'Search',
              color: context.appColors.brand.primary,
            ),
          ),
        ),
      ),
    );
  }

  _defaultBorder(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: context.radius.all.extraLarge,
      borderSide: BorderSide(
        color: showBorder
            ? context.appColors.brandSecondary.accentGreen
            : context.appColors.brand.primary,
      ),
    );
  }
}
