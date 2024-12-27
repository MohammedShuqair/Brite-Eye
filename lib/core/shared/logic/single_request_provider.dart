import 'package:brite_eye/core/data/network/api_response.dart';
import 'package:brite_eye/core/data/network/app_exception.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../data/network/error_message.dart';
import '../../helpers/navigation_helper.dart';

abstract class SingleRequestProvider<T> extends ChangeNotifier {
  ApiResponse<T>? response;

  void setState(ApiResponse<T> apiResponse) {
    response = apiResponse;
    notifyListeners();
  }

  bool isLoading() {
    return response?.loading() ?? false;
  }

  Future<Either<AppException, T>> callRequest(Object? params);

  void handleSuccess(T serverResponse);

  void _handleSuccess(T serverResponse) {
    setState(ApiResponse.completed(serverResponse));
    handleSuccess(serverResponse);
  }

  bool requestGard() => true;

  Future<void> performRequest({Object? params}) async {
    if (requestGard()) {
      setState(ApiResponse.loading());
      _handleResponse(params: params);
    }
  }

  void _handleResponse({Object? params}) async {
    try {
      final result = await callRequest(params);
      result.fold(handleError, _handleSuccess);
    } catch (e) {
      handleError(AppException(statusCode: -1, errors: [
        ErrorMessage(message: "An error occurred, please try again later")
      ]));
    }
  }

  void handleError(AppException e) {
    String? message = e.createErrorMessage();
    if (message?.isNotEmpty ?? false) {
      NavigationHelper.showSnackBar(message!);
    }
    setState(ApiResponse.error(message: e.toString()));
  }
}
