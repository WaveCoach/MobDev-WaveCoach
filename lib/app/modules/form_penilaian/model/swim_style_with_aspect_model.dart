class Assessment {
  final int studentId;
  final String assessmentDate;
  final int packageId;
  final int scheduleId;
  final List<Category> categories;

  Assessment({
    required this.studentId,
    required this.assessmentDate,
    required this.packageId,
    required this.scheduleId,
    required this.categories,
  });

  Map<String, dynamic> toJson() {
    return {
      'student_id': studentId,
      'assessment_date': assessmentDate,
      'package_id': packageId,
      'schedule_id': scheduleId,
      'categories': categories.map((category) => category.toJson()).toList(),
    };
  }
}

class Category {
  final int assessmentCategoryId;
  final List<Detail> details;

  Category({required this.assessmentCategoryId, required this.details});

  Map<String, dynamic> toJson() {
    return {
      'assessment_category_id': assessmentCategoryId,
      'details': details.map((detail) => detail.toJson()).toList(),
    };
  }
}

class Detail {
  final int aspectId;
  final int score;
  final String remarks;

  Detail({required this.aspectId, required this.score, required this.remarks});

  Map<String, dynamic> toJson() {
    return {'aspect_id': aspectId, 'score': score, 'remarks': remarks};
  }
}
