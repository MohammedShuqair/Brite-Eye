import 'package:brite_eye/core/data/network/api_base_helper.dart';
import 'package:brite_eye/core/data/network/app_exception.dart';
import 'package:brite_eye/core/data/network/endpoint.dart';
import 'package:brite_eye/core/data/network/repository_helper.dart';
import 'package:brite_eye/faetures/child/model/create_child_response.dart';
import 'package:brite_eye/faetures/child/repo/params/craet_child_params.dart';
import 'package:dartz/dartz.dart';

import '../../profile/models/user.dart';
import '../model/child_model.dart';

class ChildRepository {
  final ApiBaseHelper apiBaseHelper;
  final DefaultRepository defaultRepository;

  ChildRepository({
    required this.apiBaseHelper,
    required this.defaultRepository,
  });

  Future<Either<AppException, CreateChildResponse>> createChild(
      ChildParams params) async {
    User? childUser;
    final either = await defaultRepository.call(
        request: () => apiBaseHelper.post(Endpoint.users, {
              "name": params.name,
              "email": "${DateTime.now().millisecondsSinceEpoch}@gmail.com",
              "password": "securepassword123",
              "password_confirmation": "securepassword123",
              "role": "child",
            }),
        resultBuilder: (serverResponse) async {
          return User.fromJson(serverResponse['data']);
        });
    either.fold((l) => null, (r) => childUser = r);

    if (childUser != null) {
      params.userId = childUser!.id;
    }
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

  //get List<Child>
  Future<Either<AppException, List<Child>>> getChildren(int caregiverId) async {
    return defaultRepository.call(
      request: () => apiBaseHelper.get(Endpoint.child),
      resultBuilder: (json) async {
        final list =
            (json['data'] as List).map((e) => Child.fromJson(e)).toList();
        return list
            .where((element) => element.caregiversId == caregiverId)
            .toList();
      },
    );
  }
}
