import 'package:mob_dev_wave_coach/app/modules/schedule_detail/model/schedule_detail_model.dart';

class ScheduleDetail {
  final int id;
  final String date;
  final String startTime;
  final String endTime;
  final String status;
  final String formattedDate;
  final Location location;
  final Coach coach;
  final List<Student> students;

  ScheduleDetail({
    required this.id,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.formattedDate,
    required this.location,
    required this.coach,
    required this.students,
  });

  factory ScheduleDetail.fromJson(Map<String, dynamic> json) {
    return ScheduleDetail(
      id: json['schedule']['id'] as int,
      date: json['schedule']['date'] as String,
      startTime: json['schedule']['start_time'] as String,
      endTime: json['schedule']['end_time'] as String,
      status: json['schedule']['status'] as String,
      formattedDate: json['schedule']['formatted_date'] as String,
      location: Location.fromJson(json['location']),
      coach: Coach.fromJson(json['coach']),
      students:
          (json['students'] as List)
              .map((student) => Student.fromJson(student))
              .toList(),
    );
  }
}
