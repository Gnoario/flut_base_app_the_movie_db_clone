import 'utils.dart';

bool isResponsiveMode(context) =>
    ResponsiveHelper.isMobile(context) || ResponsiveHelper.isTablet(context);
