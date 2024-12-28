// To parse this JSON data, do
//
//     final session = sessionFromJson(jsonString);

import 'dart:convert';

Session sessionFromJson(String str) => Session.fromJson(json.decode(str));

String sessionToJson(Session data) => json.encode(data.toJson());

class Session {
  int? id;
  int? childId;
  int? doctorId;
  DateTime? sessionDate;
  double? visionLevel;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  Session({
    this.id,
    this.childId,
    this.doctorId,
    this.sessionDate,
    this.visionLevel,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  Map<String, int>? formatVisionLevel() {
    if (visionLevel != null) {
      int upper = 6; // Always set lower to 6
      int lower = (visionLevel! * upper).ceil(); // Calculate the upper level

      return {
        'upper': upper,
        'lower': lower,
      };
    }
  }

  String? get visionLevelString {
    Map<String, int>? map = formatVisionLevel();
    if (map != null) {
      return '${map['lower']} / ${map['upper']}';
    }
  }

  factory Session.fromJson(Map<String, dynamic> json) {
    dynamic visionLevel = json["vision_level"];
    if (visionLevel is String) {
      visionLevel = double.tryParse(visionLevel);
    }
    if (visionLevel is int) {
      visionLevel = visionLevel.toDouble();
    }
    return Session(
      id: json["id"],
      childId: json["child_id"],
      doctorId: json["doctor_id"],
      sessionDate: json["session_date"] == null
          ? null
          : DateTime.parse(json["session_date"]),
      visionLevel: visionLevel,
      description: json["description"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      deletedAt: json["deleted_at"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "child_id": childId,
        "doctor_id": doctorId,
        "session_date":
            "${sessionDate?.year.toString().padLeft(4, '0')}-${sessionDate?.month.toString().padLeft(2, '0')}-${sessionDate?.day.toString().padLeft(2, '0')}",
        "vision_level": visionLevel,
        "description": description,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
