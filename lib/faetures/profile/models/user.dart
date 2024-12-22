// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int? id;
  String? name;
  String? email;
  String? role;
  String? gender;
  dynamic caregiversId;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    this.name,
    this.email,
    this.role,
    this.gender,
    this.caregiversId,
    this.createdAt,
    this.updatedAt,
  });

  void copyWith(User another) {
    id = another.id ?? id;
    name = another.name ?? name;
    email = another.email ?? email;
    role = another.role?? role;
    gender = another.gender??gender;
    caregiversId = another.caregiversId??caregiversId;
    createdAt = another.createdAt??createdAt;
    updatedAt = another.updatedAt??updatedAt;
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        role: json["role"],
        gender: json["gender"],
        caregiversId: json["caregivers_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "role": role,
        "gender": gender,
        "caregivers_id": caregiversId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };

}
