import 'package:mob_dev_wave_coach/app/modules/history_penilaian/model/history_penilaian_model.dart';

class AssessmentHistoryResponse {
  final bool success;
  final String message;
  final List<AssessmentHistory> data;

  AssessmentHistoryResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AssessmentHistoryResponse.fromJson(Map<String, dynamic> json) {
    return AssessmentHistoryResponse(
      success: json['success'],
      message: json['message'],
      data: List<AssessmentHistory>.from(
        json['data'].map((x) => AssessmentHistory.fromJson(x)),
      ),
    );
  }
}
