import 'package:brite_eye/core/data/local/shared_preferences.dart';
import 'package:brite_eye/core/data/network/app_exception.dart';
import 'package:brite_eye/core/helpers/date_formater.dart';
import 'package:brite_eye/core/helpers/navigation_helper.dart';
import 'package:brite_eye/faetures/child/model/create_child_response.dart';
import 'package:brite_eye/faetures/child/repo/child_repository.dart';
import 'package:brite_eye/faetures/child/repo/params/craet_child_params.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../core/shared/logic/single_request_provider.dart';
import '../model/child_model.dart';

class ChildFormProvider extends SingleRequestProvider<CreateChildResponse> {
  final ChildRepository childRepository;
  final Child? child;

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final visionLevelUpperController = TextEditingController();
  final visionLevelLowerController = TextEditingController();
  final otherDetailsController = TextEditingController();
  int? caregiverId;
  DateTime? birthDate;
  DateTime? lastExaminationDate;
  String? weakEye;

  String get title => child == null ? "Add Child" : "Edit Child";

  ChildFormProvider(
      {required this.childRepository, this.child, required this.caregiverId}) {
    if (caregiverId == null) {
      SharedHelper.clear();
      NavigationHelper.exitApp();
    }
    if (child != null) {
      setChildData(child!);
    }
  }

  @override
  Future<Either<AppException, CreateChildResponse>> callRequest(_) {
    var params = ChildParams(
      caregiverId: caregiverId,
      name: nameController.text,
      visionLevel: calcVisionLevel(),
      birthDate: DateFormatter.formatToYYYYMMDD(birthDate),
      lastExamDate: DateFormatter.formatToYYYYMMDD(lastExaminationDate),
      weakEye: weakEye,
      otherDetails: otherDetailsController.text,
      userId: caregiverId,
    );
    if (child == null) {
      return childRepository.createChild(params);
    } else {
      return childRepository.updateChild(params);
    }
  }

  @override
  void handleSuccess(CreateChildResponse serverResponse) {
    NavigationHelper.showSnackBar(serverResponse.message, isError: false);
    NavigationHelper.pop();
  }

  @override
  bool requestGard() {
    return formKey.currentState?.validate() ?? false;
  }

  double calcVisionLevel() =>
      int.parse(visionLevelUpperController.text) /
      int.parse(visionLevelLowerController.text);

  void setChildData(Child child) {
    nameController.text = child.name ?? '';
    Map<String, int>? map = child.formatVisionLevel();
    visionLevelUpperController.text = map?['upper'].toString() ?? '6';
    visionLevelLowerController.text = map?['lower'].toString() ?? '0';

    birthDate = child.birthDate;
    lastExaminationDate = child.lastExamDate;
    weakEye = child.weakEye;
    otherDetailsController.text = child.otherDetails ?? "";
  }

  void setBirthDate(DateTime? date) {
    birthDate = date;
    notifyListeners();
  }

  void setLastExaminationDate(DateTime? date) {
    lastExaminationDate = date;
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    visionLevelUpperController.dispose();
    visionLevelLowerController.dispose();
    otherDetailsController.dispose();
    super.dispose();
  }
}
