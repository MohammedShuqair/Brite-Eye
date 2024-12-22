// To parse this JSON data, do
//
//     final authResponse = authResponseFromJson(jsonString);

import 'dart:convert';

import 'package:brite_eye/faetures/profile/models/user.dart';

AuthResponse authResponseFromJson(String str) =>
    AuthResponse.fromJson(json.decode(str));

String authResponseToJson(AuthResponse data) => json.encode(data.toJson());

class AuthResponse {
  String? message;
  User? user;
  String? token;

  AuthResponse({
    this.message,
    this.user,
    this.token,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        message: json["message"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "user": user?.toJson(),
        "token": token,
      };
}
