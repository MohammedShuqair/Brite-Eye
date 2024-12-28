import 'package:brite_eye/core/extentions/color_theme.dart';
import 'package:brite_eye/core/helpers/navigation_helper.dart';
import 'package:brite_eye/core/helpers/user_helper.dart';
import 'package:brite_eye/faetures/activities/ui/activities_screen.dart';
import 'package:brite_eye/faetures/doctor/logic/doctor_provider.dart';
import 'package:flutter/material.dart';

import '../../../core/shared/vars/lang.dart';
import '../../doctor/ui/doctor_screen.dart';
import '../../profile/ui/profile_screen.dart';

/// A logic class for managing the state and logic of the home screen.
class HomeProvider extends ChangeNotifier {
  /// The timestamp of the last back press.
  DateTime? currentBackPressTime;

  DoctorProvider doctorProvider;

  /// A flag indicating whether the app can pop now.
  bool canPopNow = false;

  /// Constructs a [HomeProvider] and initializes the user logic.
  ///
  /// [userProvider] - The user logic to update the user from local storage.
  HomeProvider({required this.doctorProvider});

  /// Handles the back button press.
  ///
  /// [didPop] - Whether the back button was pressed.
  /// [dynamic] - Additional data.
  /// [context] - The build context.
  void handelPop(bool didPop, Object? dynamic, BuildContext context) async {
    final now = DateTime.now();
    if (_isFirstTap(now)) {
      _handelFirstTap(now, context);
    } else {
      _handelSecondTap();
    }
  }

  /// Handles the second tap of the back button.
  void _handelSecondTap() {
    canPopNow = true;
    notifyListeners();
    NavigationHelper.exitApp();
  }

  /// Handles the first tap of the back button.
  ///
  /// [now] - The current timestamp.
  /// [context] - The build context.
  void _handelFirstTap(DateTime now, BuildContext context) {
    currentBackPressTime = now;
    canPopNow = false;
    notifyListeners();
    NavigationHelper.showSnackBar(
      kLocalize.please_click_double_tap_to_exit,
      background: context.onSurface,
    );
    return;
  }

  /// Determines whether the current tap is the first tap.
  ///
  /// [now] - The current timestamp.
  /// Returns true if it is the first tap, false otherwise.
  bool _isFirstTap(DateTime now) {
    return currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2);
  }

  /// The current index of the selected bottom navigation item.
  int currentIndex = 0;

  /// A list of screens corresponding to each bottom navigation item.
  /// Don't use const to enable language change in profile screen.
  List<Widget> get screens => [
        ActivitiesScreen(),
        DoctorScreen(
          doctorProvider: doctorProvider,
        ),
        const ProfileScreen(),
      ];

  /// Returns the currently selected screen based on [currentIndex].
  Widget get currentScreen => screens[currentIndex];

  /// Sets the [currentIndex] to the given [index] and notifies listeners.
  ///
  /// [index] - The new index to set as the current index.
  void setIndex(int index) {
    currentIndex = index;
    switch (index) {
      case 1:
        final child = UserHelper.getSelectedChild();
        if (child != null) {
          doctorProvider.performMoreRequest(params: child.userId);
        }
        break;
    }
    notifyListeners();
  }
}
