import 'package:brite_eye/core/helpers/user_helper.dart';
import 'package:brite_eye/faetures/all_doctors/models/doctor.dart';
import 'package:brite_eye/faetures/child/model/child_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../repository/user_repository.dart';

class UserProvider extends ChangeNotifier {
  User? user;
  Child? selectedChild;
  Doctor? selectedDoctor;
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
    getSelectedChild();
    getSelectedDoctor();
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

  void getSelectedChild() {
    final child = UserHelper.getSelectedChild();
    selectedChild = child;
    notifyListeners();
  }

  void saveSelectedChild(Child? child) {
    var childId = child?.userId;
    print("added $childId");

    if (childId != null) {
      selectedChild = child;
      UserHelper.saveSelectedChild(child!);
      print("updated");

      notifyListeners();
    }
  }

  bool isChildSelected(int? childId) {
    if (childId != null) {
      return selectedChild?.userId == childId;
    }
    return false;
  }

  bool childSelected() {
    return selectedChild?.userId != null;
  }

  void getSelectedDoctor() {
    final doctor = UserHelper.getSelectedDoctor();
    selectedDoctor = doctor;
    notifyListeners();
  }

  void saveSelectedDoctor(Doctor? doctor) {
    var doctorId = doctor?.id;
    print("added $doctorId");

    if (doctorId != null) {
      selectedDoctor = doctor;
      UserHelper.saveSelectedDoctor(doctor!);
      print("updated");

      notifyListeners();
    }
  }

  bool isDoctorSelected(int? doctorId) {
    if (doctorId != null) {
      return selectedDoctor?.id == doctorId;
    }
    return false;
  }

  bool doctorSelected() {
    return selectedDoctor != null;
  }
}
