import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flut_base_app_the_movie_db_clone/app/ui/components/components.dart';
import 'package:flut_base_app_the_movie_db_clone/core/theme/theme.dart';
import 'package:flut_base_app_the_movie_db_clone/shared/shared.dart';
import 'package:flutter/material.dart';

class CustomDropdownButton extends StatefulWidget {
  final ValueChanged<String?>? onChanged;
  final List<String> items;
  final String? initialValue;
  const CustomDropdownButton({
    super.key,
    this.onChanged,
    this.initialValue,
    required this.items,
  });

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  String? value;
  @override
  void initState() {
    super.initState();
    setState(() {
      value = widget.initialValue ?? widget.items.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        underline: null,
        onChanged: (value) {
          setState(() {
            this.value = value;
          });
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
        },
        items: widget.items
            .map(
              (e) => DropdownMenuItem<String>(
                value: e,
                child: Padding(
                  padding: context.spacer.right.xxs,
                  child: BaseText(
                    text: e,
                    color: context.appColors.brandSecondary.secondary,
                  ),
                ),
              ),
            )
            .toList(),
        hint: BaseText(
          text: value!,
          gradient: context.appColors.brandSecondary.gradientGreen,
        ),
        buttonStyleData: ButtonStyleData(
          height: 40,
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.black26,
            ),
            color: context.appColors.brandSecondary.secondary,
          ),
          elevation: 2,
        ),
        iconStyleData: IconStyleData(
          icon: Transform.rotate(
            angle: 1.5708,
            child: const Icon(
              Icons.arrow_forward_ios_outlined,
            ),
          ),
          iconSize: 14,
          iconEnabledColor: context.appColors.brandSecondary.accentGreen,
          iconDisabledColor: Colors.grey,
          openMenuIcon: Transform.rotate(
            angle: -1.5708,
            child: const Icon(
              Icons.arrow_forward_ios_outlined,
            ),
          ),
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: context.radius.all.medium,
            gradient: context.appColors.brandSecondary.gradientGreen,
          ),
          offset: const Offset(-5, 0),
          scrollbarTheme: const ScrollbarThemeData(
            radius: Radius.circular(40),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
        ),
      ),
    );
  }
}
