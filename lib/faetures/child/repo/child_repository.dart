import 'package:brite_eye/core/data/network/api_base_helper.dart';
import 'package:brite_eye/core/data/network/app_exception.dart';
import 'package:brite_eye/core/data/network/endpoint.dart';
import 'package:brite_eye/core/data/network/repository_helper.dart';
import 'package:brite_eye/faetures/child/model/create_child_response.dart';
import 'package:brite_eye/faetures/child/repo/params/craet_child_params.dart';
import 'package:dartz/dartz.dart';

class ChildRepository {
  final ApiBaseHelper apiBaseHelper;
  final DefaultRepository defaultRepository;

  ChildRepository({
    required this.apiBaseHelper,
    required this.defaultRepository,
  });

  Future<Either<AppException, CreateChildResponse>> createChild(
      ChildParams params) async {
    return defaultRepository.call(
      request: () => apiBaseHelper.post(Endpoint.child, params.toJson()),
      resultBuilder: (json) async {
        return CreateChildResponse.fromJson(json);
      },
    );
  }

  Future<Either<AppException, CreateChildResponse>> updateChild(
      ChildParams params) async {
    return defaultRepository.call(
      request: () => apiBaseHelper.put(Endpoint.child, params.toJson()),
      resultBuilder: (json) async {
        return CreateChildResponse.fromJson(json);
      },
    );
  }
}
