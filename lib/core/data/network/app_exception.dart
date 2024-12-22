import 'package:brite_eye/core/data/network/error_message.dart';

/// A custom exception class for handling API errors.
class AppException implements Exception {
  /// The HTTP status code of the error.
  final int statusCode;

  /// A map of validation errors returned from the API.
  final Map<String, dynamic>? validationErrors;

  /// A list of error messages returned from the API.
  final List<ErrorMessage>? errors;

  /// A flag indicating whether the error is a validation error.
  final bool isValidationError;

  /// Creates an instance of [AppException].
  ///
  /// [statusCode] is the HTTP status code of the error.
  /// [validationErrors] is a map of validation errors returned from the API.
  /// [errors] is a list of error messages returned from the API.
  /// [isValidationError] is a flag indicating whether the error is a validation error.
  AppException({
    required this.statusCode,
    this.validationErrors,
    this.errors,
    this.isValidationError = false,
  });

  /// Creates an instance of [AppException] from a JSON object.
  ///{
  ///     "error": {
  ///         "key1": [
  ///             "message content"
  ///         ],
  ///         "key2": [
  ///             "message content"
  ///         ]
  ///     }
  /// }
  /// Or
  /// {"error":"Invalid credentials"}
  static AppException fromJson(Map<String, dynamic> json, int statusCode) {
    dynamic errorsMap = json['error'];
    List<ErrorMessage> errors = [];

    if (errorsMap != null) {
      if (errorsMap is String) {
        errors.add(ErrorMessage(message: errorsMap));
      }
      if (errorsMap is Map) {
        errorsMap.forEach((key, value) {
          if (value is List) {
            errors.add(ErrorMessage(message: value.join(', ')));
          }
          if (value is String) {
            errors.add(ErrorMessage(message: value));
          }
        });
      }
    }
    return AppException(
      statusCode: statusCode,
      validationErrors: json['validationErrors'],
      errors: errors,
      isValidationError: errors.isEmpty,
    );
  }

  /// Creates a human-readable error message from the validation errors or error messages.
  ///
  /// Returns a string containing the error message, or null if no message is available.
  String? createErrorMessage() {
    String? message;
    if (isValidationError) {
      dynamic listOfLists = validationErrors?.values;
      if (listOfLists is Iterable) {
        listOfLists = listOfLists.expand((e) => e).toList();
        if (listOfLists.isNotEmpty) {
          message = listOfLists.join(', ');
        }
      }
    } else {
      if (errors?.isNotEmpty ?? false) {
        message = errors
            ?.where((e) => e.message != null)
            .map((e) => e.message)
            .join(', ');
      }
    }
    return message;
  }
}
