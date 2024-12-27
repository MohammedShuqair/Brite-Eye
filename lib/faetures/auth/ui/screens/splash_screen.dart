import 'package:brite_eye/core/extentions/color_theme.dart';
import 'package:brite_eye/faetures/auth/ui/screens/login_screen.dart';
import 'package:flutter/material.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/helpers/navigation_helper.dart';
import '../../../../core/helpers/user_helper.dart';
import '../../../home/ui/home_screen.dart';
import '../../../profile/models/user.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void init() async {
    await Future.delayed(const Duration(seconds: 2));
    String token = await UserHelper.getUserToken();
    User? user = UserHelper.getUserFromLocal();
    if (token.isNotEmpty && user != null) {
      NavigationHelper.pushAndRemoveUntil(HomeScreen.id);
    } else {
      NavigationHelper.pushAndRemoveUntil(LoginScreen.id);
    }
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.primaryFixed,
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            context.primary,
            context.primaryFixed,
          ])),
          child: SafeArea(
            child: Center(
              child: Assets.icons.logo.image(
                fit: BoxFit.cover,
                width: 120,
                height: 120,
              ),
            ),
          ),
        ));
  }
}
