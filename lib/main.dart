import 'package:brite_eye/core/routing/router.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'core/data/local/shared_preferences.dart';
import 'core/di/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedHelper.init();
  setupLocator();
  runApp(MyApp(
    router: router,
    langProvider: locator(),
    userProvider: locator(),
  ));
}
