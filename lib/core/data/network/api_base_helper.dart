import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:brite_eye/core/data/network/error_message.dart';
import 'package:brite_eye/core/data/network/logging_Interceptor.dart';
import 'package:brite_eye/core/extentions/print_extenstion.dart';
import 'package:brite_eye/core/helpers/lang_helper.dart';
import 'package:brite_eye/core/shared/vars/lang.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';

import '../local/shared_preferences.dart';
import 'app_exception.dart';

/// A helper class for making API requests with common methods for GET, POST, PUT, DELETE, and file uploads.
mixin class ApiBaseHelper {
  /// The HTTP client with interceptors for logging.
  static http.Client client = InterceptedClient.build(
    interceptors: [LoggingInterceptor()],
  );

  /// Returns the headers for the request, including authorization if `withToken` is true.
  ///
  /// [withToken] indicates whether to include the authorization token in the headers.
  Future<Map<String, String>> getHeaders(bool withToken) async {
    Map<String, String> headers = {
      HttpHeaders.acceptHeader: '*/*',
      'Content-Type': 'application/json',
      "lang": LangHelper.instance.code,
    };
    if (withToken) {
      String? token = await SharedHelper.getSecuredString(PrefKeys.token);
      headers.addAll({
        HttpHeaders.authorizationHeader: "Bearer $token",
      });
    }
    return headers;
  }

  /// Makes a GET request to the given URL.
  ///
  /// [url] is the endpoint to send the request to.
  /// [withToken] indicates whether to include the authorization token in the headers.
  /// Returns the response as a map of key-value pairs.
  Future<Map<String, dynamic>> get(
    String url, {
    bool withToken = true,
  }) async {
    Map<String, dynamic> responseJson;
    try {
      final response = await client.get(
        Uri.parse(url),
        headers: await getHeaders(withToken),
      );
      "get ---- ${response.body}".printLongString();
      responseJson = _returnResponse(
        response.body,
        response.statusCode,
      );
    } on SocketException {
      throw AppException(
        statusCode: -1,
        errors: [ErrorMessage(message: kLocalize.no_internet_connection)],
      );
    }
    return responseJson;
  }

  /// Makes a GET request to the given URL and returns the response body as bytes.
  ///
  /// [url] is the endpoint to send the request to.
  /// [withToken] indicates whether to include the authorization token in the headers.
  /// Returns the response body as a list of bytes.
  Future<Uint8List?> getBodyBytes(
    String url, {
    bool withToken = true,
  }) async {
    try {
      final response = await client.get(
        Uri.parse(url),
        headers: await getHeaders(withToken),
      );
      return response.bodyBytes;
    } on SocketException {
      throw AppException(
        statusCode: -1,
        errors: [ErrorMessage(message: kLocalize.no_internet_connection)],
      );
    }
  }

  /// Makes a POST request to the given URL with the provided body.
  ///
  /// [url] is the endpoint to send the request to.
  /// [body] is the request payload.
  /// [withToken] indicates whether to include the authorization token in the headers.
  /// Returns the response as a map of key-value pairs.
  Future<Map<String, dynamic>> post(
    String url,
    Map<String, dynamic>? body, {
    bool withToken = true,
  }) async {
    Map<String, dynamic> responseJson;
    try {
      final response = await client.post(
        Uri.parse(url),
        headers: await getHeaders(withToken),
        body: jsonEncode(body),
      );
      log("post ---- ${response.body}");

      responseJson = _returnResponse(response.body, response.statusCode);
      print("response.body $responseJson");
    } on SocketException catch (e, s) {
      print("error ${e.toString()}");
      print("stack ${s.toString()}");
      throw AppException(
        statusCode: -1,
        errors: [ErrorMessage(message: kLocalize.no_internet_connection)],
      );
    }
    return responseJson;
  }

  /// Makes a PUT request to the given URL with the provided body.
  ///
  /// [url] is the endpoint to send the request to.
  /// [body] is the request payload.
  /// [withToken] indicates whether to include the authorization token in the headers.
  /// Returns the response as a map of key-value pairs.
  Future<Map<String, dynamic>> put(
    String url,
    Map<String, dynamic>? body, {
    bool withToken = true,
  }) async {
    Map<String, dynamic> responseJson;
    try {
      final response = await client.put(Uri.parse(url),
          body: body, headers: await getHeaders(withToken));
      responseJson = _returnResponse(response.body, response.statusCode);
    } on SocketException {
      throw AppException(
        statusCode: -1,
        errors: [ErrorMessage(message: kLocalize.no_internet_connection)],
      );
    }
    return responseJson;
  }

  /// Makes a DELETE request to the given URL with the provided body.
  ///
  /// [url] is the endpoint to send the request to.
  /// [body] is the request payload.
  /// [withToken] indicates whether to include the authorization token in the headers.
  /// Returns the response as a map of key-value pairs.
  Future<Map<String, dynamic>> delete(
    String url, {
    Map<String, dynamic>? body,
    bool withToken = true,
  }) async {
    Map<String, dynamic> responseJson;
    try {
      final response = await client.delete(Uri.parse(url),
          body: body, headers: await getHeaders(withToken));
      responseJson = _returnResponse(response.body, response.statusCode);
    } on SocketException {
      throw AppException(
        statusCode: -1,
        errors: [ErrorMessage(message: kLocalize.no_internet_connection)],
      );
    }
    return responseJson;
  }

  /// Makes a POST request to the given URL with the provided body and file.
  ///
  /// [url] is the endpoint to send the request to.
  /// [body] is the request payload.
  /// [filePath] is the path to the file to be uploaded.
  /// [withToken] indicates whether to include the authorization token in the headers.
  /// [field] is the form field name for the file.
  /// Returns the response as a map of key-value pairs.
  Future<Map<String, dynamic>> postWithFile(
    String url,
    Map<String, String> body, {
    String? filePath,
    bool withToken = true,
    String field = 'image',
  }) async {
    if (filePath != null) {
      return await postFiles(url,
          files: {field: filePath}, withToken: withToken, body: body);
    } else {
      return await post(url, body);
    }
  }

  /// Makes a POST request to the given URL with the provided body and multiple files.
  ///
  /// [url] is the endpoint to send the request to.
  /// [files] is a map of form field names to file paths.
  /// [withToken] indicates whether to include the authorization token in the headers.
  /// [body] is the request payload.
  /// Returns the response as a map of key-value pairs.
  Future<Map<String, dynamic>> postFiles(
    String url, {
    Map<String, String> files = const {},
    bool withToken = true,
    Map<String, String> body = const {},
  }) async {
    Map<String, dynamic> responseJson;

    try {
      var request = http.MultipartRequest("POST", Uri.parse(url));
      files.forEach((field, path) async {
        var pic = await http.MultipartFile.fromPath(field, path);

        request.files.add(pic);
      });

      if (body.isNotEmpty) {
        request.fields.addAll(body);
      }
      request.headers.addAll(await getHeaders(withToken));
      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      print("responseString $responseString");
      responseJson = _returnResponse(responseString, response.statusCode);
    } on SocketException {
      throw AppException(
        statusCode: -1,
        errors: [ErrorMessage(message: kLocalize.no_internet_connection)],
      );
    }
    return responseJson;
  }

  /// Makes a POST request to the given URL with the provided body and multiple files for a single field.
  ///
  /// [url] is the endpoint to send the request to.
  /// [files] is a map of form field names to lists of file paths.
  /// [withToken] indicates whether to include the authorization token in the headers.
  /// [body] is the request payload.
  /// Returns the response as a map of key-value pairs.
  Future<Map<String, dynamic>> postMultiFilesField(
    String url, {
    Map<String, List<String>> files = const {},
    bool withToken = true,
    Map<String, String> body = const {},
  }) async {
    Map<String, dynamic> responseJson;

    try {
      var request = http.MultipartRequest("POST", Uri.parse(url));
      files.forEach((field, paths) async {
        for (String path in paths) {
          var pic = await http.MultipartFile.fromPath(field, path);
          request.files.add(pic);
        }
      });

      if (body.isNotEmpty) {
        request.fields.addAll(body);
      }
      request.headers.addAll(await getHeaders(withToken));
      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      print("responseString $responseString");
      responseJson = _returnResponse(responseString, response.statusCode);
    } on SocketException {
      throw AppException(
        statusCode: -1,
        errors: [ErrorMessage(message: kLocalize.no_internet_connection)],
      );
    }
    return responseJson;
  }

  /// Parses the response body and returns it as a map of key-value pairs.
  ///
  /// [body] is the response body as a string.
  /// [statusCode] is the HTTP status code of the response.
  /// Throws an [AppException] if the response is not a valid JSON or if the status code is not 200.
  Map<String, dynamic> _returnResponse(String body, int statusCode) {
    dynamic responseJson;
    try {
      responseJson = json.decode(body);
      if (responseJson is List) {
        Map<String, dynamic> temp = {"data": responseJson};
        responseJson = temp;
      }
    } catch (e) {
      log("not-json $body");
      throw AppException(
          statusCode: -2,
          errors: [ErrorMessage(message: kLocalize.server_error)]);
    }

    if (statusCode == 200 || statusCode == 201) {
      return responseJson;
    } else {
      throw AppException.fromJson(
        responseJson,
        statusCode,
      );
    }
  }
}
