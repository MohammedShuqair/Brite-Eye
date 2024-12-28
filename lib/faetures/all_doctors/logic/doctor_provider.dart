import 'package:brite_eye/core/data/network/app_exception.dart';
import 'package:brite_eye/faetures/all_doctors/models/doctor.dart';
import 'package:brite_eye/faetures/all_doctors/repo/doctor_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../core/shared/logic/single_request_provider.dart';

class DoctorsProvider extends SingleRequestProvider<List<Doctor>> {
  final DoctorRepository childRepository;

  DoctorsProvider({
    required this.childRepository,
  }) {
    performRequest();
  }

  @override
  Future<Either<AppException, List<Doctor>>> callRequest(_) {
    return childRepository.getDoctor();
  }

  @override
  void handleSuccess(List<Doctor> serverResponse) {}
}
