import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppSettings {
  static Future<void> init({
    String initialRoute = '/',
    required Module module,
  }) async {
    _initModule(module);
    Modular.setInitialRoute(initialRoute);
  }

  static void _initModule(Module module) async {
    WidgetsFlutterBinding.ensureInitialized();

    Modular.init(module);
  }
}
