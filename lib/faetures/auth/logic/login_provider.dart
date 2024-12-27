import 'package:brite_eye/core/helpers/navigation_helper.dart';
import 'package:brite_eye/faetures/home/ui/home_screen.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/data/network/api_response.dart';
import '../../../core/data/network/app_exception.dart';
import '../../../core/shared/vars/lang.dart';
import '../models/auth_response.dart';
import '../repository/auth_repository.dart';

/// A logic class for managing login-related logic and state.
class LoginProvider extends ChangeNotifier {
  /// The repository for authentication-related operations.
  final AuthRepository _authRepository;

  /// The API response for the login request.
  ApiResponse<AuthResponse>? response;

  /// The form key for the login form.
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// The controller for the email input field.
  final TextEditingController emailController = TextEditingController();

  /// The controller for the password input field.
  final TextEditingController passwordController = TextEditingController();

  /// Constructor for initializing the LoginProvider with the given context.
  LoginProvider() : _authRepository = AuthRepository();

  /// Initiates the login process if the input is valid.
  Future<void> login() async {
    if (_validateInput()) {
      _setState(ApiResponse.loading());
      await _performLogin();
    }
  }

  /// Sets the current state of the API response and notifies listeners.
  ///
  /// [apiResponse] - The API response to set.
  void _setState(ApiResponse<AuthResponse> apiResponse) {
    response = apiResponse;
    notifyListeners();
  }

  /// Validates the input fields.
  ///
  /// Returns true if the input is valid, false otherwise.
  bool _validateInput() {
    return formKey.currentState?.validate() ?? false;
  }

  /// Checks if the login process is currently loading.
  ///
  /// Returns true if the process is loading, false otherwise.
  bool isLoading() {
    return response?.loading() ?? false;
  }

  /// Performs the login operation by calling the AuthRepository.
  Future<void> _performLogin() async {
    _performAuth(
        call: _authRepository.login(
      emailController.text,
      passwordController.text,
    ));
  }

  /// Performs the authentication operation by calling the AuthRepository.
  ///
  /// [call] - The authentication call to perform.
  Future<void> _performAuth({
    required Future<Either<AppException, AuthResponse?>> call,
  }) async {
    try {
      Either<AppException, AuthResponse?> response = await call;
      _handleResponse(
        response,
      );
    } catch (e) {
      _setState(ApiResponse.error(message: kLocalize.unknown_error));
      // _handleError(e.toString());
    }
  }

  /// Handles the server response after the authentication attempt.
  ///
  /// [serverResponse] - The server response to handle.
  void _handleResponse(
    Either<AppException, AuthResponse?> serverResponse,
  ) async {
    serverResponse.fold((e) {
      _handleError(e);
    }, (loginResponse) {
      _setState(ApiResponse.completed(loginResponse));
      _handelSuccess();
      // NavigationHelper.pushAndRemoveUntil(const HomeScreen());
    });
  }

  /// Handles the success scenario after the authentication attempt.
  void _handelSuccess() {
    if (hasData()) {
      var message = response!.data!.message;
      if (message != null) {
        NavigationHelper.showSnackBar(message, isError: false);
      }
      _handelNavigation();
    }
  }

  /// Checks if the response has data.
  ///
  /// Returns true if the response has data, false otherwise.
  bool hasData() =>
      response!.data!.token != null && response!.data!.user != null;

  /// Handles navigation based on the status from the API response.
  void _handelNavigation() {
    NavigationHelper.pushAndRemoveUntil(HomeScreen.id);
  }

  /// Handles errors that occur during the authentication process.
  ///
  /// [e] - The exception to handle.
  void _handleError(AppException e) {
    String? message = e.createErrorMessage();
    if (message?.isNotEmpty ?? false) {
      NavigationHelper.showSnackBar(message!);
    }
    _setState(ApiResponse.error(message: e.toString()));
  }

  /// Disposes of the controllers when the logic is no longer needed.
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
