import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'responsive_type.dart';

class ResponsiveHelper {
  static const double desktopLargeSize = 1440;
  static const double desktopSize = 1024;
  static const double tabletSize = 768;
  static const double mobileSize = 425;
  static const double watchSize = 200;

  static bool isDesktopLarge(BuildContext context) {
    ResponsiveType type = getType(context);
    return type == ResponsiveType.desktopLarge;
  }

  static bool isDesktop(BuildContext context) {
    ResponsiveType type = getType(context);

    if (type == ResponsiveType.desktopLarge || type == ResponsiveType.desktop) {
      return true;
    }

    return false;
  }

  static bool isTablet(BuildContext context) {
    ResponsiveType type = getType(context);
    return type == ResponsiveType.tablet;
  }

  static bool isMobile(BuildContext context) {
    ResponsiveType type = getType(context);
    return type == ResponsiveType.mobile;
  }

  static ResponsiveType getType(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final type = getDeviceType(size);
    final data = type.toCCResponsiveType(context);
    return data;
  }

  static void setDefaultBreakpoints({
    double? desktop,
    double? watch,
    double? tablet,
  }) {
    ResponsiveSizingConfig.instance.setCustomBreakpoints(
      ScreenBreakpoints(
        desktop: desktop ?? desktopSize,
        tablet: tablet ?? tabletSize,
        watch: watch ?? watchSize,
      ),
      customRefinedBreakpoints: const RefinedBreakpoints(
        // Desktop
        desktopLarge: desktopLargeSize,
        desktopNormal: desktopSize,
        tabletExtraLarge: tabletSize,
        tabletSmall: 426,
        mobileExtraLarge: 425,
      ),
    );
  }
}
