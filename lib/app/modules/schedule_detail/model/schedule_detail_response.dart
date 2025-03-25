import 'package:mob_dev_wave_coach/app/modules/schedule_detail/model/schedule_detail_model.dart';

class ScheduleDetailResponse {
  final bool success;
  final String message;
  final Schedule schedule;
  final Location location;
  final Coach coach;
  final List<Student> students;

  ScheduleDetailResponse({
    required this.success,
    required this.message,
    required this.schedule,
    required this.location,
    required this.coach,
    required this.students,
  });

  factory ScheduleDetailResponse.fromJson(Map<String, dynamic> json) {
    return ScheduleDetailResponse(
      success: json['success'],
      message: json['message'],
      schedule: Schedule.fromJson(json['data']['schedule']),
      location: Location.fromJson(json['data']['location']),
      coach: Coach.fromJson(json['data']['coach']),
      students:
          (json['data']['students'] as List)
              .map((e) => Student.fromJson(e))
              .toList(),
    );
  }
}
