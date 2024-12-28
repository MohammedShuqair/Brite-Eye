import 'dart:convert';

import 'package:brite_eye/core/data/local/shared_preferences.dart';
import 'package:brite_eye/faetures/child/model/child_model.dart';

import '../../faetures/profile/models/user.dart';

/// A helper class for managing user-related data in local storage.
class UserHelper {
  /// Retrieves the user data from local storage.
  ///
  /// Returns a [User] object if the user data is found, otherwise returns null.
  static User? getUserFromLocal() {
    String? json = SharedHelper.getString(key: PrefKeys.userModel);
    if (json != null) {
      return userFromJson(json);
    }
    return null;
  }

  /// Saves the user data to local storage.
  ///
  /// [user] is the [User] object to be saved. If [user] is null, no action is taken.
  static Future<void> saveUserToLocal(User? user) async {
    if (user != null) {
      await SharedHelper.setString(
          key: PrefKeys.userModel, value: userToJson(user));
    }
  }

  /// Retrieves the user token from local storage.
  ///
  /// Returns the user token as a [String].
  static Future<String> getUserToken() async {
    return await SharedHelper.getSecuredString(PrefKeys.token);
  }

  /// Saves the user token to local storage.
  ///
  /// [token] is the user token to be saved. If [token] is null, no action is taken.
  static Future<void> saveUserToken(String? token) async {
    if (token != null) {
      await SharedHelper.setSecuredString(PrefKeys.token, token);
    }
  }

  static Future<void> saveSelectedChild(Child child) async {
    await SharedHelper.setString(
        key: PrefKeys.selectedChild, value: jsonEncode(child.toJson()));
  }

  static Child? getSelectedChild() {
    String? json = SharedHelper.getString(key: PrefKeys.selectedChild);
    if (json != null) {
      return Child.fromJson(jsonDecode(json));
    }
    return null;
  }
}
