import 'package:brite_eye/core/di/service_locator.dart';
import 'package:brite_eye/faetures/activities/examination/ishihara/ui/result_screen.dart';
import 'package:brite_eye/faetures/all_children/logic/children_provider.dart';
import 'package:brite_eye/faetures/all_doctors/logic/doctor_provider.dart';
import 'package:brite_eye/faetures/auth/ui/screens/login_screen.dart';
import 'package:brite_eye/faetures/auth/ui/screens/signup_screen.dart';
import 'package:brite_eye/faetures/child/logic/child_form_provider.dart';
import 'package:brite_eye/faetures/home/ui/home_screen.dart';
import 'package:brite_eye/faetures/profile/logic/user_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../faetures/activities/examination/ishihara/logic/Ishihara_provider.dart';
import '../../faetures/activities/examination/ishihara/ui/ishihara_screen.dart';
import '../../faetures/activities/games/ui/follow_ball.dart';
import '../../faetures/all_children/ui/children_screen.dart';
import '../../faetures/all_doctors/ui/doctors_screen.dart';
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
        builder: (context, state) {
          return ChangeNotifierProvider.value(
            value: locator<HomeProvider>(),
            child: HomeScreen(),
          );
        },
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
        builder: (context, state) {
          return ChangeNotifierProvider.value(
            value: locator<ChildrenProvider>(),
            child: ChildrenScreen(),
          );
        },
      ),
      GoRoute(
        path: IshiharaScreen.id,
        name: IshiharaScreen.id,
        builder: (context, state) {
          return ChangeNotifierProvider.value(
            value: locator<IshiharaProvider>(),
            child: IshiharaScreen(),
          );
        },
      ),
      GoRoute(
        path: ResultScreen.id,
        name: ResultScreen.id,
        builder: (context, state) {
          Map<String, dynamic> args = state.extra as Map<String, dynamic>;

          return ResultScreen(
            title: args['title'],
            score: args['score'],
          );
        },
      ),
      GoRoute(
        path: DoctorsScreen.id,
        name: DoctorsScreen.id,
        builder: (context, state) {
          return ChangeNotifierProvider.value(
            value: locator<DoctorsProvider>(),
            child: DoctorsScreen(),
          );
        },
      ),
      GoRoute(
        path: FollowBallScreen.id,
        name: FollowBallScreen.id,
        builder: (context, state) => FollowBallScreen(),
      ),
    ]);
