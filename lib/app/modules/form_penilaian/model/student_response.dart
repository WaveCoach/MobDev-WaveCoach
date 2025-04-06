import 'package:mob_dev_wave_coach/app/modules/form_penilaian/model/student_model.dart';

class StudentResponse {
  final bool success;
  final String message;
  final List<Student> data;

  StudentResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory StudentResponse.fromJson(Map<String, dynamic> json) {
    return StudentResponse(
      success: json['success'],
      message: json['message'],
      data:
          (json['data'] as List).map((item) => Student.fromJson(item)).toList(),
    );
  }
}
