import 'package:mob_dev_wave_coach/app/modules/schedule_detail/model/schedule_detail_model.dart';

class ScheduleDetailResponse {
  final bool success;
  final String message;
  final ScheduleDetail data;

  ScheduleDetailResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ScheduleDetailResponse.fromJson(Map<String, dynamic> json) {
    return ScheduleDetailResponse(
      success: json['success'],
      message: json['message'],
      data: ScheduleDetail.fromJson(json['data']),
    );
  }
}
