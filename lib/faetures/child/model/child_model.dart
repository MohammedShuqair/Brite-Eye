class Child {
  int? userId;
  String? name;
  DateTime? birthDate;
  String? weakEye;
  String? otherDetails;
  double? visionLevel;
  DateTime? lastExamDate;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? caregiversId;

  Child(
      {this.userId,
      this.name,
      this.birthDate,
      this.weakEye,
      this.otherDetails,
      this.visionLevel,
      this.lastExamDate,
      this.updatedAt,
      this.createdAt,
      this.caregiversId});

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

  factory Child.fromJson(Map<String, dynamic> json) {
    dynamic visionLevel = json["vision_level"];
    if (visionLevel is String) {
      visionLevel = double.tryParse(visionLevel);
    }
    return Child(
        userId: json["user_id"],
        name: json["name"],
        birthDate: json["birth_date"] == null
            ? null
            : DateTime.parse(json["birth_date"]),
        weakEye: json["weak_eye"],
        otherDetails: json["other_details"],
        visionLevel: visionLevel,
        lastExamDate: json["last_exam_date"] == null
            ? null
            : DateTime.parse(json["last_exam_date"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        caregiversId: json["caregivers_id"]);
  }

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "name": name,
        "birth_date":
            "${birthDate!.year.toString().padLeft(4, '0')}-${birthDate!.month.toString().padLeft(2, '0')}-${birthDate!.day.toString().padLeft(2, '0')}",
        "weak_eye": weakEye,
        "other_details": otherDetails,
        "vision_level": visionLevel,
        "last_exam_date":
            "${lastExamDate!.year.toString().padLeft(4, '0')}-${lastExamDate!.month.toString().padLeft(2, '0')}-${lastExamDate!.day.toString().padLeft(2, '0')}",
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "caregivers_id": caregiversId
      };
}
