import 'package:flut_base_app_the_movie_db_clone/shared/shared.dart';
import 'package:flutter/material.dart';

import '../components.dart';

class BaseHeader extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;
  final bool isLoading;

  const BaseHeader({
    super.key,
    required this.title,
    this.trailing,
    this.padding,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? context.spacer.y.xs + context.spacer.x.xs,
      child: Row(
        children: [
          BaseText(
            text: title,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }

  factory BaseHeader.header({
    required String title,
  }) {
    return BaseHeader(
      title: title,
    );
  }

  factory BaseHeader.headerWithFilter({
    required BuildContext context,
    required String title,
    required List<String> children,
    required ValueChanged<int?> onValueChanged,
    final String? initialValue,
    required int groupValue,
    bool isLoading = false,
  }) {
    return BaseHeader(
      title: title,
      isLoading: isLoading,
      trailing: Padding(
        padding: context.spacer.left.xs,
        child: isResponsiveMode(context)
            ? CustomDropdownButton(
                items: children,
                initialValue: initialValue,
                onChanged: (value) {
                  onValueChanged(
                    children.indexOf(value ?? ''),
                  );
                },
              )
            : SegmentedSlidingCard(
                onValueChanged: onValueChanged,
                children: children
                    .asMap()
                    .map(
                      (index, value) {
                        return MapEntry(
                          index,
                          SlidingCard(
                            selected: groupValue == index,
                            text: value,
                          ),
                        );
                      },
                    )
                    .values
                    .toList(),
              ),
      ),
    );
  }
}
