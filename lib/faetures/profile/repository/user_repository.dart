import 'package:dartz/dartz.dart';

import '../../../core/data/network/api_base_helper.dart';
import '../../../core/data/network/app_exception.dart';
import '../../../core/data/network/endpoint.dart';
import '../../../core/data/network/repository_helper.dart';
import '../models/user.dart';

class UserRepository with ApiBaseHelper, DefaultRepository {
  Future<Either<AppException, User?>> getUser(int id) async {
    return await call<User>(
        request: () => get(
              Endpoint.getCurrentUser.replaceFirst("[id]", "$id"),
            ),
        resultBuilder: (serverModel) async {
          return User.fromJson(serverModel["data"]);
        });
  }
}
