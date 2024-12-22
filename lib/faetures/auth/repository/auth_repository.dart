import 'package:brite_eye/faetures/auth/repository/params/sign_up_params.dart';
import 'package:dartz/dartz.dart';

import '../../../core/data/network/api_base_helper.dart';
import '../../../core/data/network/app_exception.dart';
import '../../../core/data/network/endpoint.dart';
import '../../../core/data/network/repository_helper.dart';
import '../../../core/helpers/user_helper.dart';
import '../../profile/models/user.dart';
import '../models/auth_response.dart';

/// A repository class for managing authentication-related operations.
class AuthRepository with ApiBaseHelper, DefaultRepository {
  /// Logs in a user with the provided email and password.
  ///
  /// [email] - The user's email address.
  /// [password] - The user's password.
  /// Returns an [Either] containing an [AppException] or an [AuthResponse].
  Future<Either<AppException, AuthResponse?>> login(
      String email, String password) async {
    return await call<AuthResponse>(
        request: () => post(
              Endpoint.login,
              {
                "email": email,
                "password": password,
              },
              withToken: false,
            ),
        resultBuilder: (serverModel) async {
          final response = AuthResponse.fromJson(serverModel);
          await _saveAuthResponse(response);
          return response;
        });
  }

  /// Signs up a user with the provided sign-up parameters.
  ///
  /// [signUpParams] - The parameters for signing up.
  /// Returns an [Either] containing an [AppException] or an [AuthResponse].
  Future<Either<AppException, AuthResponse?>> signUp(
      SignUpParams signUpParams) async {
    return await call<AuthResponse>(
        request: () => post(
              Endpoint.register,
              signUpParams.toJson(),
              withToken: false,
            ),
        resultBuilder: (serverModel) async {
          final response = AuthResponse.fromJson(serverModel);
          await _saveAuthResponse(response);
          return response;
        });
  }

  /// Saves the authentication response.
  ///
  /// [r] - The authentication response to save.
  Future<void> _saveAuthResponse(AuthResponse r) async {
    await _saveToken(r.token);
    await _saveUserData(r.user);
  }

  /// Saves the user's token.
  ///
  /// [token] - The token to save.
  Future<void> _saveToken(String? token) async {
    UserHelper.saveUserToken(token);
  }

  /// Saves the user's data to local storage.
  ///
  /// [user] - The user data to save.
  Future<void> _saveUserData(User? user) async {
    await UserHelper.saveUserToLocal(user);
  }
}
