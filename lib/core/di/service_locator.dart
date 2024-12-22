import 'package:brite_eye/core/shared/controllers/langprovider.dart';
import 'package:brite_eye/faetures/auth/logic/login_provider.dart';
import 'package:brite_eye/faetures/home/logic/home_provider.dart';
import 'package:brite_eye/faetures/profile/logic/user_provider.dart';
import 'package:get_it/get_it.dart';

import '../../faetures/auth/logic/signup_provider.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  // Register Providers
  locator.registerFactory(() => SingUpProvider());
  locator.registerFactory(() => LoginProvider());
  locator.registerLazySingleton(() => LangProvider());
  locator.registerLazySingleton(() => UserProvider());
  locator.registerFactory(() => HomeProvider(locator()));
}
