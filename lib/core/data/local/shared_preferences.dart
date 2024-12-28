import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Enum representing the keys used in shared preferences.
enum PrefKeys { language, token, onBoarding, userModel, selectedChild }

/// A helper class for managing shared preferences and secure storage.
class SharedHelper {
  /// The instance of [SharedPreferences].
  static SharedPreferences? sharedPreferences;

  /// Initializes the [SharedPreferences] instance.
  static init() async {
    sharedPreferences ??= await SharedPreferences.getInstance();
  }

  static bool get isInitialized => sharedPreferences != null;

  /// Stores a boolean value in shared preferences.
  ///
  /// [key] is the key under which the value is stored.
  /// [value] is the boolean value to be stored.
  /// Returns a [Future] that completes with true if the value was successfully written.
  static Future<bool> putBool({
    required PrefKeys key,
    required var value,
  }) async {
    return await sharedPreferences!.setBool(key.name, value);
  }

  /// Retrieves a boolean value from shared preferences.
  ///
  /// [key] is the key under which the value is stored.
  /// Returns the boolean value, or null if the key does not exist.
  static bool? getBool({
    required PrefKeys key,
  }) {
    return sharedPreferences!.getBool(key.name);
  }

  /// Stores a double value in shared preferences.
  ///
  /// [key] is the key under which the value is stored.
  /// [value] is the double value to be stored.
  /// Returns a [Future] that completes with true if the value was successfully written.
  static Future<bool> putDouble({
    required PrefKeys key,
    required dynamic value,
  }) async {
    return await sharedPreferences!.setDouble(key.name, value);
  }

  /// Retrieves a double value from shared preferences.
  ///
  /// [key] is the key under which the value is stored.
  /// Returns the double value, or null if the key does not exist.
  static double? getDouble({
    required PrefKeys key,
  }) {
    return sharedPreferences!.getDouble(key.name);
  }

  /// Stores a string value in shared preferences.
  ///
  /// [key] is the key under which the value is stored.
  /// [value] is the string value to be stored.
  /// Returns a [Future] that completes with true if the value was successfully written.
  static Future<bool> setString({
    required PrefKeys key,
    required String value,
  }) async {
    return await sharedPreferences!.setString(key.name, value);
  }

  /// Retrieves a string value from shared preferences.
  ///
  /// [key] is the key under which the value is stored.
  /// Returns the string value, or null if the key does not exist.
  static String? getString({
    required PrefKeys key,
  }) {
    return sharedPreferences!.getString(key.name);
  }

  /// Stores an integer value in shared preferences.
  ///
  /// [key] is the key under which the value is stored.
  /// [value] is the integer value to be stored.
  /// Returns a [Future] that completes with true if the value was successfully written.
  static Future<bool> putInt({
    required PrefKeys key,
    required int value,
  }) async {
    return await sharedPreferences!.setInt(key.name, value);
  }

  /// Retrieves an integer value from shared preferences.
  ///
  /// [key] is the key under which the value is stored.
  /// Returns the integer value, or null if the key does not exist.
  static int? getInt({required PrefKeys key}) {
    return sharedPreferences!.getInt(key.name);
  }

  /// Retrieves a secured string value from secure storage.
  ///
  /// [key] is the key under which the value is stored.
  /// Returns the string value, or an empty string if the key does not exist.
  static Future<String> getSecuredString(PrefKeys key) async {
    const flutterSecureStorage = FlutterSecureStorage();
    debugPrint('FlutterSecureStorage : getSecuredString with key :');
    return await flutterSecureStorage.read(key: key.name) ?? '';
  }

  /// Saves a string value in secure storage.
  ///
  /// [key] is the key under which the value is stored.
  /// [value] is the string value to be stored.
  static Future<void> setSecuredString(PrefKeys key, String value) async {
    const flutterSecureStorage = FlutterSecureStorage();
    debugPrint(
        "FlutterSecureStorage : setSecuredString with key : $key and value : $value");
    await flutterSecureStorage.write(key: key.name, value: value);
  }

  /// Removes all keys and values in the secure storage.
  static Future<void> clearAllSecuredData() async {
    debugPrint('FlutterSecureStorage : all data has been cleared');
    const flutterSecureStorage = FlutterSecureStorage();
    await flutterSecureStorage.deleteAll();
  }

  /// Clears all data in shared preferences and secure storage, except for language and onboarding data.
  static Future<void> clear() async {
    print("-----------------clearing user data-----------------");
    await clearAllSecuredData();
    for (PrefKeys key in PrefKeys.values) {
      if (key != PrefKeys.language && key != PrefKeys.onBoarding) {
        await removeValue(key);
      }
    }
  }

  /// Removes a value from shared preferences.
  ///
  /// [key] is the key under which the value is stored.
  /// Returns a [Future] that completes with true if the value was successfully removed.
  static Future<bool> removeValue(PrefKeys key) async {
    return await sharedPreferences!.remove(key.name);
  }
}
