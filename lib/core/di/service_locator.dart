import 'package:brite_eye/core/data/network/api_base_helper.dart';
import 'package:brite_eye/core/data/network/repository_helper.dart';
import 'package:brite_eye/core/shared/controllers/langprovider.dart';
import 'package:brite_eye/faetures/all_children/logic/children_provider.dart';
import 'package:brite_eye/faetures/auth/logic/login_provider.dart';
import 'package:brite_eye/faetures/child/repo/child_repository.dart';
import 'package:brite_eye/faetures/home/logic/home_provider.dart';
import 'package:brite_eye/faetures/profile/logic/user_provider.dart';
import 'package:get_it/get_it.dart';

import '../../faetures/activities/examination/ishihara/logic/Ishihara_provider.dart';
import '../../faetures/auth/logic/signup_provider.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  // Register Helpers
  locator.registerLazySingleton(() => ApiBaseHelper());
  locator.registerLazySingleton(() => DefaultRepository());

  // Register Repositories
  locator.registerLazySingleton(() => ChildRepository(
        apiBaseHelper: locator(),
        defaultRepository: locator(),
      ));

  // Register Providers
  locator.registerFactory(() => SingUpProvider());
  locator.registerFactory(() => LoginProvider());
  locator.registerFactory(() => IshiharaProvider());

  // Register Permanent Providers
  locator.registerLazySingleton(() => LangProvider());
  locator.registerLazySingleton(() => UserProvider());
  locator.registerLazySingleton(() {
    return HomeProvider();
  });

  locator.registerLazySingleton(
      () => ChildrenProvider(childRepository: locator()));
}
