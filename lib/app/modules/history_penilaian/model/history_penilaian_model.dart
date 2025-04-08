class AssessmentHistory {
  final int id;
  final String date;
  final int studentId;
  final String studentName;
  final int assessorId;
  final String assessorName;
  final int packageId;
  final String packageName;
  final int categoryId;
  final String categoryName;

  AssessmentHistory({
    required this.id,
    required this.date,
    required this.studentId,
    required this.studentName,
    required this.assessorId,
    required this.assessorName,
    required this.packageId,
    required this.packageName,
    required this.categoryId,
    required this.categoryName,
  });

  factory AssessmentHistory.fromJson(Map<String, dynamic> json) {
    return AssessmentHistory(
      id: json['id'],
      date: json['date'],
      studentId: json['student']['id'],
      studentName: json['student']['name'],
      assessorId: json['assessor']['id'],
      assessorName: json['assessor']['name'],
      packageId: json['package']['id'],
      packageName: json['package']['name'],
      categoryId: json['category']['id'],
      categoryName: json['category']['name'],
    );
  }
}
