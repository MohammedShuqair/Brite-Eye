import 'package:brite_eye/core/data/network/app_exception.dart';
import 'package:brite_eye/faetures/all_doctors/repo/doctor_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../core/shared/logic/single_request_provider.dart';
import '../models/session_model.dart';

class DoctorProvider extends SingleRequestProvider<List<Session>> {
  final DoctorRepository childRepository;

  DoctorProvider({
    required this.childRepository,
  });

  @override
  Future<Either<AppException, List<Session>>> callRequest(childId) {
    return childRepository.getSessions(childId as int);
  }

  @override
  void handleSuccess(List<Session> serverResponse) {}
}
