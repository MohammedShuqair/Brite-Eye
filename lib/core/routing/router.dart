import 'package:brite_eye/core/di/service_locator.dart';
import 'package:brite_eye/faetures/all_children/logic/children_provider.dart';
import 'package:brite_eye/faetures/auth/ui/screens/login_screen.dart';
import 'package:brite_eye/faetures/auth/ui/screens/signup_screen.dart';
import 'package:brite_eye/faetures/child/logic/child_form_provider.dart';
import 'package:brite_eye/faetures/home/ui/home_screen.dart';
import 'package:brite_eye/faetures/profile/logic/user_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../faetures/all_children/ui/children_screen.dart';
import '../../faetures/auth/logic/signup_provider.dart';
import '../../faetures/auth/ui/screens/splash_screen.dart';
import '../../faetures/child/model/child_model.dart';
import '../../faetures/child/ui/child_form_screen.dart';
import '../../faetures/home/logic/home_provider.dart';
import '../helpers/navigation_helper.dart';

GoRouter router = GoRouter(
    navigatorKey: NavigationHelper.navigatorKey,
    initialLocation: "/",
    routes: [
      GoRoute(
        path: "/",
        name: "/",
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: SignupScreen.id,
        name: SignupScreen.id,
        builder: (context, state) {
          return ChangeNotifierProvider.value(
            value: locator<SingUpProvider>(),
            child: const SignupScreen(),
          );
        },
      ),
      GoRoute(
        path: LoginScreen.id,
        name: LoginScreen.id,
        builder: (context, state) => LoginScreen(
          loginProvider: locator(),
        ),
      ),
      GoRoute(
        path: HomeScreen.id,
        name: HomeScreen.id,
        builder: (context, state) => ChangeNotifierProvider.value(
          value: locator<HomeProvider>(),
          child: HomeScreen(),
        ),
      ),
      GoRoute(
        path: ChildFormScreen.id,
        name: ChildFormScreen.id,
        builder: (context, state) => ChangeNotifierProvider.value(
          value: ChildFormProvider(
              childRepository: locator(),
              caregiverId: locator<UserProvider>().user?.id,
              child: state.extra as Child?),
          child: ChildFormScreen(),
        ),
      ),
      GoRoute(
        path: ChildrenScreen.id,
        name: ChildrenScreen.id,
        builder: (context, state) => ChangeNotifierProvider.value(
          value: locator<ChildrenProvider>(),
          child: ChildrenScreen(),
        ),
      ),
    ]);
