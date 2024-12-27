import 'package:brite_eye/core/helpers/navigation_helper.dart';
import 'package:brite_eye/faetures/home/ui/home_screen.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/data/network/api_response.dart';
import '../../../core/data/network/app_exception.dart';
import '../models/auth_response.dart';
import '../repository/auth_repository.dart';
import '../repository/params/sign_up_params.dart';

/// A logic class for managing sign-up related logic and state.
class SingUpProvider extends ChangeNotifier {
  /// The repository for authentication-related operations.
  final AuthRepository _authRepository;

  /// The API response for the sign-up request.
  ApiResponse<AuthResponse>? response;

  /// The form key for the sign-up form.
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// The controller for the name input field.
  final TextEditingController nameController = TextEditingController();

  /// The controller for the email input field.
  final TextEditingController emailController = TextEditingController();

  /// The controller for the password input field.
  final TextEditingController passwordController = TextEditingController();

  /// The controller for the confirm password input field.
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String? gender;

  /// Constructor for initializing the SingUpProvider with the given context.
  ///
  /// [userProvider] - The user logic for managing user-related state.
  SingUpProvider() : _authRepository = AuthRepository() {
    print("build SingUpProvider");
  }

  void setGender(String value) {
    gender = value;
    notifyListeners();
  }

  /// Initiates the sign-up process if the input is valid.
  Future<void> signUp() async {
    if (_validateInput()) {
      _setState(ApiResponse.loading());
      await _performSignUp();
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

  /// Checks if the sign-up process is currently loading.
  ///
  /// Returns true if the process is loading, false otherwise.
  bool isLoading() {
    return response?.loading() ?? false;
  }

  /// Performs the sign-up operation by calling the AuthRepository.
  Future<void> _performSignUp() async {
    try {
      Either<AppException, AuthResponse?> response =
          await _authRepository.signUp(
        SignUpParams(
          name: nameController.text,
          email: emailController.text,
          password: passwordController.text,
          confirmPassword: confirmPasswordController.text,
          gender: gender!,
          role: "caregiver",
        ),
      );
      _handleResponse(response);
    } catch (e, s) {
      print("error ${e.toString()}");
      print("stack ${s.toString()}");
      _setState(ApiResponse.error(message: "error"));
      // _handleError(e.toString());
    }
  }

  /// Handles the server response after the sign-up attempt.
  ///
  /// [serverResponse] - The server response to handle.
  void _handleResponse(
    Either<AppException, AuthResponse?> serverResponse,
  ) async {
    serverResponse.fold((e) {
      _handleError(e);
    }, (signUpResponse) {
      _setState(ApiResponse.completed(signUpResponse));
      _handelSuccess();
    });
  }

  /// Handles the success scenario after the sign-up attempt.
  void _handelSuccess() {
    if (hasData()) {
      if (response!.data!.message != null) {
        NavigationHelper.showSnackBar(
          response!.data!.message!,
          isError: false,
        );
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

  /// Handles errors that occur during the sign-up process.
  ///
  /// [e] - The exception to handle.
  void _handleError(AppException e) {
    String? message = e.createErrorMessage();
    if (message != null) {
      NavigationHelper.showSnackBar(message);
    }
    _setState(ApiResponse.error(message: e.toString()));
  }

  /// Disposes of the controllers when the logic is no longer needed.
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    super.dispose();
  }
}
