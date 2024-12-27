import 'package:brite_eye/core/helpers/lang_helper.dart';
import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

/// A logic class for managing language settings in the application.
///
/// This class extends [ChangeNotifier] to notify listeners when the locale changes.
class LangProvider with ChangeNotifier {
  /// Creates an instance of [LangProvider] and initializes the current locale.
  LangProvider() {
    _currentLocale = Locale(LangHelper.instance.code);
  }

  /// Returns a list of supported locales.
  List<Locale> get supportedLocales {
    return S.delegate.supportedLocales;
  }

  /// The current locale of the application.
  late Locale _currentLocale;

  /// Gets the current locale.
  Locale get currentLocale => _currentLocale;

  /// Changes the locale of the application.
  ///
  /// [locale] - The new locale code to be set. If [locale] is null, no action is taken.
  void changeLocale(String? locale) {
    if (locale != null) {
      LangHelper.instance.code = locale;
      S.load(Locale(locale));
      _currentLocale = Locale(locale);
      notifyListeners();
    }
  }
}
