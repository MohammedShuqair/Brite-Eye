import 'package:brite_eye/core/data/network/api_base_helper.dart';
import 'package:brite_eye/core/data/network/app_exception.dart';
import 'package:brite_eye/core/data/network/repository_helper.dart';
import 'package:brite_eye/faetures/all_doctors/models/doctor.dart';
import 'package:brite_eye/faetures/doctor/models/session_model.dart';
import 'package:dartz/dartz.dart';

import '../../../core/data/network/endpoint.dart';

class DoctorRepository {
  final ApiBaseHelper apiBaseHelper;
  final DefaultRepository defaultRepository;

  DoctorRepository({
    required this.apiBaseHelper,
    required this.defaultRepository,
  });

  Future<Either<AppException, List<Doctor>>> getDoctor() async {
    return defaultRepository.call(
      request: () => apiBaseHelper.get(Endpoint.doctors),
      resultBuilder: (json) async {
        return (json['data'] as List).map((e) => Doctor.fromJson(e)).toList();
      },
    );
  }

  Future<Either<AppException, List<Session>>> getSessions(int childId) async {
    return defaultRepository.call(
      request: () => apiBaseHelper.get(Endpoint.sessions),
      resultBuilder: (json) async {
        final list =
            (json['data'] as List).map((e) => Session.fromJson(e)).toList();
        return list.where((element) => element.childId == childId).toList();
      },
    );
  }
}
