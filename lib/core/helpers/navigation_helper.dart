import 'dart:io';

import 'package:brite_eye/core/extentions/snak_bar.dart';
import 'package:brite_eye/core/routing/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/local/shared_preferences.dart';

/// A helper class for managing navigation within the application.
class NavigationHelper {
  /// A global key for accessing the navigator state.
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Pushes a new page onto the navigation stack.
  ///
  /// [page] is the widget to be pushed onto the stack.
  /// Returns a [Future] that completes to the result value passed to [pop] when the pushed page is popped off the stack.
  static Future<T?>? push<T>(String page, {Object? extra}) {
    return router.pushNamed<T>(page, extra: extra);
  }

  /// Replaces the current page with a new page.
  ///
  /// [page] is the widget to replace the current page.
  /// Returns a [Future] that completes to the result value passed to [pop] when the replaced page is popped off the stack.
  static Future<T?> pushReplacement<T>(String page, {Object? extra}) {
    return router.pushReplacementNamed<T>(
      page,
      extra: extra,
    );
  }

  /// Pushes a new page and removes all the previous pages until the predicate returns true.
  ///
  /// [page] is the widget to be pushed onto the stack.
  /// Returns a [Future] that completes to the result value passed to [pop] when the pushed page is popped off the stack.
  static Future<T?>? pushAndRemoveUntil<T>(String page, {Object? extra}) {
    while (router.canPop()) {
      router.pop();
    }
    return router.pushReplacementNamed<T>(page, extra: extra);
  }

  static void popUntilName(
    List<String> routePaths, {
    String fallbackPath = "/",
    Object? extra,
  }) {
    while (!routePaths.contains(router.state?.name ?? "")) {
      if (!router.canPop()) {
        router.pushReplacementNamed(fallbackPath);
        return;
      }

      debugPrint('Popping ${router.state?.name}');
      router.pop();
    }
  }

  /// Pops the top-most page off the navigation stack.
  ///
  /// [result] is the optional result to return to the previous page.
  static void pop<T>([T? result]) {
    router.pop<T>(result);
  }

  /// Shows a SnackBar with the given message.
  ///
  /// [message] is the text to display in the SnackBar.
  /// [isError] determines the background color of the SnackBar. If true, the background color will be [inverseSurface], otherwise [primary].
  /// [background] is an optional parameter to specify a custom background color.
  static void showSnackBar(String? message,
      {bool isError = true, Color? background}) {
    if (message != null) {
      navigatorKey.currentContext
          ?.showSnackBar(message, isError: isError, background: background);
    }
  }

  /// Pops all pages and removes user data from shared preferences.
  ///
  /// Clears the user data and navigates back to the first page.
  static Future<void> popAndRemoveUserData() async {
    await SharedHelper.clear();
    // popUntilName([LoginScreen.id], fallbackPath: LoginScreen.id);
  }

  /// Exits the application.
  ///
  /// If the platform is Android, it uses [SystemNavigator.pop] to exit.
  /// Otherwise, it uses [exit(0)] to terminate the app.
  static void exitApp() {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else {
      exit(0);
    }
  }
}
