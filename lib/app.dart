import 'package:brite_eye/core/shared/controllers/langprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'core/generated/l10n.dart';
import 'core/utils/style/themes.dart';
import 'faetures/profile/logic/user_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp(
      {super.key,
      required this.router,
      required this.langProvider,
      required this.userProvider});

  final GoRouter router;
  final LangProvider langProvider;
  final UserProvider userProvider;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    /// Initialize the ScreenUtil for app scaling
    return ScreenUtilInit(
        designSize: const Size(402, 874),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider.value(
                value: langProvider,
              ),
              ChangeNotifierProvider.value(
                value: userProvider,
              ),
            ],
            child: Consumer<LangProvider>(
              builder: (context, langProvider, child) {
                return MaterialApp.router(
                  routerConfig: router,
                  // navigatorKey: NavigationHelper.navigatorKey,
                  locale: langProvider.currentLocale,
                  localeResolutionCallback:
                      (Locale? locale, Iterable<Locale> supportedLocales) =>
                          supportedLocales.contains(locale)
                              ? locale
                              : const Locale("en"),
                  theme: lightTheme,
                  darkTheme: lightTheme,
                  localizationsDelegates: const [
                    S.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: S.delegate.supportedLocales,
                );
              },
            ),
          );
        });
  }
}
