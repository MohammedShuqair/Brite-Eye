class ChildParams {
  final int? userId;
  final int? caregiverId;
  final String? name;
  final String? birthDate;
  final String? weakEye;
  final String? otherDetails;
  final double? visionLevel;
  final String? lastExamDate;

  ChildParams({
    this.userId,
    this.caregiverId,
    this.name,
    this.birthDate,
    this.weakEye,
    this.otherDetails,
    this.visionLevel,
    this.lastExamDate,
  });

  factory ChildParams.fromJson(Map<String, dynamic> json) {
    return ChildParams(
      userId: json['user_id'] as int?,
      caregiverId: json['caregivers_id'] as int?,
      name: json['name'] as String?,
      birthDate: json['birth_date'] as String?,
      weakEye: json['weak_eye'] as String?,
      otherDetails: json['other_details'] as String?,
      visionLevel: (json['vision_level'] as num?)?.toDouble(),
      lastExamDate: json['last_exam_date'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "user_id": userId,
      "caregivers_id": caregiverId,
      "name": name,
      "birth_date": birthDate,
      "weak_eye": weakEye,
      "other_details": otherDetails,
      "vision_level": visionLevel,
      "last_exam_date": lastExamDate,
    };
  }
}
