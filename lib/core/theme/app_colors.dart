// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

extension AppColorsExtension on BuildContext {
  AppColors get appColors => AppColors();
}

class AppColors {
  _BrandColors get brand => _BrandColors();
  _BrandSecondaryColors get brandSecondary => _BrandSecondaryColors();
  _NeutralColors get neutral => _NeutralColors();
}

class _BrandColors {
  Color get primary => Colors.white;
  Color get appGrey => const Color(0xff919191);
}

class _NeutralColors {
  Color get grey1 => Colors.grey[100]!;
  Color get grey2 => const Color(0xffDDE2E5);
  Color get grey3 => const Color(0xff8A9197);
  Color get grey4 => const Color(0xff495057);
  Color get grey5 => const Color(0xff343A40);
  Color get grey6 => const Color(0xff212529);
}

class _BrandSecondaryColors {
  Color get secondary => const Color.fromRGBO(4, 38, 66, 1);
  Color get black => const Color(0xff000000);
  Color get greyBlue => const Color(0xff017EBE);
  Color get accentBlue => const Color.fromRGBO(59, 130, 246, 0.5);
  Color get blue => const Color.fromARGB(255, 80, 142, 241);
  Color get green => const Color(0xff00FF00);
  Color get lightBlue => const Color(0xff3FB6DC);
  Color get red => const Color(0xffFF0000);
  Color get accentGreen => const Color(0xff1ed5a9);
  LinearGradient gradientGreen = const LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color(0xffc0fecf),
      Color(0xff1ed5a9),
    ],
  );
  LinearGradient searchGradient = const LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color.fromRGBO(30, 213, 169, 1),
      Color.fromRGBO(1, 180, 228, 1),
    ],
  );
}
