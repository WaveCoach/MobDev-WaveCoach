import 'package:mob_dev_wave_coach/app/modules/history_penilaian_detail/model/history_penilaian_detail_model.dart';

class HistoryDetailResponse {
  final bool success;
  final String message;
  final HistoryData data;

  HistoryDetailResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory HistoryDetailResponse.fromJson(Map<String, dynamic> json) {
    return HistoryDetailResponse(
      success: json['success'],
      message: json['message'],
      data: HistoryData.fromJson(json['data']),
    );
  }
}
