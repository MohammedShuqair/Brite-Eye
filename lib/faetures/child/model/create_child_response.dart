// To parse this JSON data, do
//
//     final createChildResponse = createChildResponseFromJson(jsonString);

import 'dart:convert';

import 'package:brite_eye/faetures/child/model/child_model.dart';

CreateChildResponse createChildResponseFromJson(String str) =>
    CreateChildResponse.fromJson(json.decode(str));

String createChildResponseToJson(CreateChildResponse data) =>
    json.encode(data.toJson());

class CreateChildResponse {
  String? message;
  Child? child;

  CreateChildResponse({
    this.message,
    this.child,
  });

  factory CreateChildResponse.fromJson(Map<String, dynamic> json) =>
      CreateChildResponse(
        message: json["message"],
        child:
            json["children"] == null ? null : Child.fromJson(json["children"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "children": child?.toJson(),
      };
}
