import '../data/local/shared_preferences.dart';

/// A helper class for managing language settings in the application.
class LangHelper {
  /// Private constructor for singleton pattern.
  LangHelper._();

  /// Singleton instance of [LangHelper].
  static final LangHelper instance = LangHelper._();

  /// Factory constructor to return the singleton instance.
  factory LangHelper() => instance;

  /// The current language code.
  String _code = 'en';

  /// Checks if the current language is right-to-left (RTL).
  ///
  /// Returns `true` if the current language is Arabic ('ar'), otherwise `false`.
  bool get isRtl => code == 'ar';

  /// Gets the current language code.
  ///
  /// Retrieves the language code from shared preferences. If no language code is found,
  /// it defaults to 'en'.
  ///
  /// Returns the current language code as a string.
  String get code {
    _code = SharedHelper.getString(key: PrefKeys.language) ?? 'en';
    print("from Local $_code");
    return _code;
  }

  /// Sets the current language code.
  ///
  /// Updates the language code in shared preferences and sets the internal [_code] variable.
  ///
  /// [code] is the new language code to be set.
  set code(String code) {
    SharedHelper.setString(key: PrefKeys.language, value: code).then((value) {
      print("gLangCode set $code");
      _code = code;
    });
  }
}
