import 'package:brite_eye/core/extentions/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/shared/controllers/langprovider.dart';
import '../logic/home_provider.dart';

class HomeScreen extends StatelessWidget {
  static const String id = '/home';

  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer2<HomeProvider, LangProvider>(
      builder: (context, provider, _, child) {
        return PopScope(
          canPop: provider.canPopNow,
          onPopInvokedWithResult: (didPop, _) =>
              provider.handelPop(didPop, _, context),
          child: Scaffold(
            body: provider.currentScreen,
            bottomNavigationBar: BottomNavigationBar(
              onTap: provider.setIndex,
              currentIndex: provider.currentIndex,
              type: BottomNavigationBarType.fixed,
              items: [
                const BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  // activeIcon: Assets.icons.bottomNav.sendSelected.svg(),
                  label: "home",
                ),
                BottomNavigationBarItem(
                  icon: Assets.icons.doctor.svg(),
                  activeIcon: Assets.icons.doctor.svg(
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      context.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: "doctor",
                ),
                BottomNavigationBarItem(
                  icon: Assets.icons.report.svg(),
                  activeIcon: Assets.icons.report.svg(
                    colorFilter: ColorFilter.mode(
                      context.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: "reports",
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: "settings",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
