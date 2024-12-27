import 'package:brite_eye/core/helpers/user_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../repository/user_repository.dart';

class UserProvider extends ChangeNotifier {
  User? user;
  final UserRepository _userRepository = UserRepository();

  static UserProvider get(BuildContext context) {
    return Provider.of<UserProvider>(context, listen: false);
  }

  void updateUserFromApi() {
    if (user?.id != null) {
      _userRepository.getUser(user!.id!).then((value) {
        value.fold((l) {
          print("Error: ${l.statusCode}");
        }, (r) {
          if (r != null) {
            user = r;
            UserHelper.saveUserToLocal(user!);
          }
          notifyListeners();
        });
      });
    }
  }

  void updateUser() {
    updateUserFromLocal();
    updateUserFromApi();
  }

  void updateUserFromLocal() {
    user = UserHelper.getUserFromLocal();
    notifyListeners();
  }

  void setUser(User user) {
    this.user = user;
    notifyListeners();
  }

  void updateUserModel(User user) {
    if (this.user != null) {
      this.user!.copyWith(user);
    }
  }
}
