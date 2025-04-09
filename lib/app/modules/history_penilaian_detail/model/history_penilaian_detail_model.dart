class HistoryData {
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
  final List<HistoryDetail> details;

  HistoryData({
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
    required this.details,
  });

  factory HistoryData.fromJson(Map<String, dynamic> json) {
    return HistoryData(
      id: json['id'],
      date: json['date'],
      studentId: json['student_id'],
      studentName: json['student_name'],
      assessorId: json['assessor_id'],
      assessorName: json['assessor_name'],
      packageId: json['package_id'],
      packageName: json['package_name'],
      categoryId: json['category_id'],
      categoryName: json['category_name'],
      details:
          (json['details'] as List)
              .map((item) => HistoryDetail.fromJson(item))
              .toList(),
    );
  }
}

class HistoryDetail {
  final int aspectId;
  final int score;
  final String remarks;

  HistoryDetail({
    required this.aspectId,
    required this.score,
    required this.remarks,
  });

  factory HistoryDetail.fromJson(Map<String, dynamic> json) {
    return HistoryDetail(
      aspectId: json['aspect_id'],
      score: json['score'],
      remarks: json['remarks'],
    );
  }
}
