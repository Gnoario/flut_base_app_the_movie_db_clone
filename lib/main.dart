import 'package:flutter/material.dart';

import 'core/start/app_module.dart';
import 'core/start/app_root.dart';
import 'core/start/app_settings.dart';

void main() async {
  await AppSettings.init(module: AppModule());

  const app = AppRoot();

  runApp(app);
}
