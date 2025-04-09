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
  final int scheduleId;
  final String scheduleDate;
  final String scheduleStartTime;
  final String scheduleEndTime;
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
    required this.scheduleId,
    required this.scheduleDate,
    required this.scheduleStartTime,
    required this.scheduleEndTime,
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
      scheduleId: json['schedule_id'],
      scheduleStartTime: json['schedule_start_time'],
      scheduleEndTime: json['schedule_end_time'],
      scheduleDate: json['schedule_date'],
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
  final String? aspectName;
  final String? aspectDesc;

  HistoryDetail({
    required this.aspectId,
    required this.score,
    required this.remarks,
    required this.aspectName,
    required this.aspectDesc,
  });

  factory HistoryDetail.fromJson(Map<String, dynamic> json) {
    return HistoryDetail(
      aspectId: json['aspect_id'],
      score: json['score'],
      remarks: json['remarks'],
      aspectName: json['aspect_name'],
      aspectDesc: json['aspect_desc'],
    );
  }
}
