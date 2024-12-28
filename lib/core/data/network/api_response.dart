import 'package:flutter/material.dart';

/// A class representing the response from an API call.
///
/// [T] is the type of data expected in the response.
class ApiResponse<T> {
  /// The status of the API response.
  ApiStatus status;

  /// The data returned from the API call.
  T? data;

  /// The message returned from the API call.
  String? message;

  /// Creates an instance of [ApiResponse] with a loading status.
  ///
  /// [message] is an optional message describing the loading state.
  ApiResponse.loading({this.message}) : status = ApiStatus.LOADING;

  /// Creates an instance of [ApiResponse] with a more status.
  ///
  /// [message] is an optional message describing the more state.
  /// [data] is the data returned from the API call.
  ApiResponse.more({this.message, this.data}) : status = ApiStatus.MORE;

  /// Creates an instance of [ApiResponse] with a completed status.
  ///
  /// [data] is the data returned from the API call.
  /// [message] is an optional message describing the completed state.
  ApiResponse.completed(this.data, {this.message})
      : status = ApiStatus.COMPLETED;

  /// Creates an instance of [ApiResponse] with an error status.
  ///
  /// [message] is an optional message describing the error state.
  ApiResponse.error({this.message}) : status = ApiStatus.ERROR;

  /// Checks if the API response is in a loading state.
  ///
  /// Returns true if the status is loading, false otherwise.
  bool loading() => status == ApiStatus.LOADING;

  bool complete() => status == ApiStatus.COMPLETED || status == ApiStatus.MORE;

  /// Builds a widget based on the current status of the API response.
  ///
  /// [loading] is a function that returns a widget to be displayed when the status is loading.
  /// [error] is a function that returns a widget to be displayed when the status is error.
  /// [completed] is a function that returns a widget to be displayed when the status is completed or more.
  ///
  /// Returns the appropriate widget based on the current status.
  Widget buildWidget({
    Widget Function()? loading,
    Widget Function()? error,
    Widget Function()? completed,
    Widget Function()? loadingOrCompleted,
  }) {
    bool statusIsCompleteOrMore =
        (status == ApiStatus.COMPLETED || status == ApiStatus.MORE);
    if (loadingOrCompleted != null &&
        (status == ApiStatus.LOADING || statusIsCompleteOrMore)) {
      return loadingOrCompleted();
    } else if (loading != null && status == ApiStatus.LOADING) {
      return loading();
    } else if (error != null && status == ApiStatus.ERROR) {
      return error();
    } else if (completed != null && statusIsCompleteOrMore) {
      return completed();
    } else {
      return Container();
    }
  }

  @override
  String toString() {
    return "Status : $status \n message : $message \n Data : $data";
  }
}

/// An enum representing the possible statuses of an API response.
enum ApiStatus { LOADING, COMPLETED, ERROR, MORE }
