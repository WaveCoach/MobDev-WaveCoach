class AssessmentAspect {
  final int id;
  final int assessmentCategoriesId;
  final String name;
  final String? desc;

  AssessmentAspect({
    required this.id,
    required this.assessmentCategoriesId,
    required this.name,
    this.desc,
  });

  factory AssessmentAspect.fromJson(Map<String, dynamic> json) {
    return AssessmentAspect(
      id: json['id'],
      assessmentCategoriesId: json['assessment_categories_id'],
      name: json['name'],
      desc: json['desc'],
    );
  }
}
