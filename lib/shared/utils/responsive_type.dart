import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

enum ResponsiveType { mobile, tablet, desktop, desktopLarge, watch }

extension EResponsiveType on DeviceScreenType {
  ResponsiveType toCCResponsiveType(BuildContext context) {
    if (this == DeviceScreenType.desktop) {
      final size = getRefinedSize(MediaQuery.sizeOf(context));

      if (size == RefinedSize.large) {
        return ResponsiveType.desktopLarge;
      }
      if (size == RefinedSize.normal) {
        return ResponsiveType.desktop;
      }
    }

    final options = {
      DeviceScreenType.mobile: ResponsiveType.mobile,
      DeviceScreenType.tablet: ResponsiveType.tablet,
      DeviceScreenType.watch: ResponsiveType.watch,
    };

    return options[this] ?? ResponsiveType.desktop;
  }
}
