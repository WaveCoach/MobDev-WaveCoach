import 'package:mob_dev_wave_coach/app/modules/schedule_detail/model/schedule_detail_model.dart';

class ScheduleResponse {
  final bool success;
  final String message;
  final ScheduleDetail schedule;
  final List<Student> students;

  ScheduleResponse({
    required this.success,
    required this.message,
    required this.schedule,
    required this.students,
  });

  factory ScheduleResponse.fromJson(Map<String, dynamic> json) {
    return ScheduleResponse(
      success: json['success'],
      message: json['message'],
      schedule: ScheduleDetail.fromJson(json['data']['schedule']),
      students:
          (json['data']['students'] as List)
              .map((student) => Student.fromJson(student))
              .toList(),
    );
  }
}
