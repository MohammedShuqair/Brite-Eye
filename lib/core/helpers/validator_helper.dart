import 'package:brite_eye/core/shared/vars/lang.dart';
import 'package:email_validator/email_validator.dart';

/// A helper class for validating various input fields.
class ValidatorHelper {
  /// Validates whether the input is a valid email.
  ///
  /// [email] - The email string to validate.
  /// Returns a validation error message if invalid, otherwise null.
  static String? validateEmail(String? email) {
    if (email == null) {
      return kLocalize.required_field;
    }
    return EmailValidator.validate(email) ? null : kLocalize.not_email;
  }

  /// Validates whether the input is a valid password.
  ///
  /// [password] - The password string to validate.
  /// Returns a validation error message if invalid, otherwise null.
  static String? validatePassword(String? password) {
    if (password?.isEmpty ?? false) {
      return kLocalize.required_field;
    }
    if (password!.length < 8) {
      return kLocalize.password_length_min;
    }
    return null;
  }

  /// Validates that the input is not empty.
  ///
  /// [value] - The input string to validate.
  /// Returns a validation error message if invalid, otherwise null.
  static String? validateNotEmpty(String? value) {
    if (value?.isEmpty ?? true) {
      return kLocalize.required_field;
    }
    return null;
  }

  /// Validates whether the confirmation password matches the original password.
  ///
  /// [confirm] - The confirmation password string to validate.
  /// [password] - The original password string to compare against.
  /// Returns a validation error message if invalid, otherwise null.
  static String? validateConfirmPassword(String? confirm, String password) {
    final isMatchWithPass = password == confirm!;
    return confirm.isEmpty
        ? kLocalize.required_field
        : isMatchWithPass
            ? null
            : kLocalize.does_match_with_password;
  }

  /// Validates whether the input is a valid name.
  ///
  /// [name] - The name string to validate.
  /// Returns a validation error message if invalid, otherwise null.
  static String? validateName(String? name) {
    if (name?.isEmpty ?? false) {
      return kLocalize.required_field;
    }
    return null;
  }
}
