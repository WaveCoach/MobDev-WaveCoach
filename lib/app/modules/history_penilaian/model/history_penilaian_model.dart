class AssessmentHistory {
  final int? id;
  final String? date;
  final int? studentId;
  final String? studentName;
  final int? assessorId;
  final String? assessorName;
  final int? packageId;
  final String? packageName;
  final int? categoryId;
  final String? categoryName;
  final DateTime? createdAt;
  final double? averageScore;
  final String? status;

  AssessmentHistory({
    this.id,
    this.date,
    this.studentId,
    this.studentName,
    this.assessorId,
    this.assessorName,
    this.packageId,
    this.packageName,
    this.categoryId,
    this.categoryName,
    this.createdAt,
    this.averageScore,
    this.status,
  });

  factory AssessmentHistory.fromJson(Map<String, dynamic> json) {
    return AssessmentHistory(
      id: json['id'] as int?,
      date: json['date'] as String?,
      studentId: json['student']?['id'] as int?,
      studentName: json['student']?['name'] as String?,
      assessorId: json['assessor']?['id'] as int?,
      assessorName: json['assessor']?['name'] as String?,
      packageId: json['package']?['id'] as int?,
      packageName: json['package']?['name'] as String?,
      categoryId: json['category']?['id'] as int?,
      categoryName: json['category']?['name'] as String?,
      createdAt:
          json['created_at'] != null
              ? DateTime.tryParse(json['created_at'])
              : null,
      averageScore: (json['average_score'] as num?)?.toDouble(),
      status: json['status'] as String?,
    );
  }
}
