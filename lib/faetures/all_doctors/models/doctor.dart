// To parse this JSON data, do
//
//     final doctor = doctorFromJson(jsonString);

import 'dart:convert';

Doctor doctorFromJson(String str) => Doctor.fromJson(json.decode(str));

String doctorToJson(Doctor data) => json.encode(data.toJson());

class Doctor {
  int? id;
  int? userId;
  String? name;
  String? description;
  double? rating;
  int? numberOfCases;
  String? contactDetails;
  String? location;
  dynamic code;
  DateTime? createdAt;
  DateTime? updatedAt;

  Doctor({
    this.id,
    this.userId,
    this.name,
    this.description,
    this.rating,
    this.numberOfCases,
    this.contactDetails,
    this.location,
    this.code,
    this.createdAt,
    this.updatedAt,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        description: json["description"],
        rating: json["rating"]?.toDouble(),
        numberOfCases: json["number_of_cases"],
        contactDetails: json["contact_details"],
        location: json["location"],
        code: json["code"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "description": description,
        "rating": rating,
        "number_of_cases": numberOfCases,
        "contact_details": contactDetails,
        "location": location,
        "code": code,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
