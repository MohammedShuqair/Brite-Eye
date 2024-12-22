import 'dart:async';
import 'dart:convert';

import 'package:http_interceptor/http_interceptor.dart';

/// A class that implements the [InterceptorContract] to log HTTP requests and responses.
class LoggingInterceptor implements InterceptorContract {
  /// Determines whether the request should be intercepted.
  ///
  /// Returns `false` indicating that the request should not be intercepted.
  @override
  FutureOr<bool> shouldInterceptRequest() {
    return false;
  }

  /// Determines whether the response should be intercepted.
  ///
  /// Returns `true` indicating that the response should be intercepted.
  @override
  FutureOr<bool> shouldInterceptResponse() {
    return true;
  }

  /// Intercepts the HTTP request.
  ///
  /// [request] is the HTTP request to be intercepted.
  /// Returns the original [request] without modification.
  @override
  FutureOr<BaseRequest> interceptRequest({required BaseRequest request}) {
    return request;
  }

  /// Intercepts the HTTP response and logs its details.
  ///
  /// [response] is the HTTP response to be intercepted.
  /// Logs the URL, status code, and headers of the response.
  /// Returns the original [response] without modification.
  @override
  FutureOr<BaseResponse> interceptResponse({required BaseResponse response}) {
    print("----- HTTP Response -----");
    print("URL: ${response.request?.url.toString()}");
    print("Status Code: ${response.statusCode}");
    print("Headers: ${jsonEncode(response.headers)}");
    print("-------------------------");
    return response;
  }
}
