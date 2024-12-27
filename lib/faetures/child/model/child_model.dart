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

  Child({
    this.userId,
    this.name,
    this.birthDate,
    this.weakEye,
    this.otherDetails,
    this.visionLevel,
    this.lastExamDate,
    this.updatedAt,
    this.createdAt,
  });

  factory Child.fromJson(Map<String, dynamic> json) => Child(
        userId: json["user_id"],
        name: json["name"],
        birthDate: json["birth_date"] == null
            ? null
            : DateTime.parse(json["birth_date"]),
        weakEye: json["weak_eye"],
        otherDetails: json["other_details"],
        visionLevel: json["vision_level"]?.toDouble(),
        lastExamDate: json["last_exam_date"] == null
            ? null
            : DateTime.parse(json["last_exam_date"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

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
      };
}
