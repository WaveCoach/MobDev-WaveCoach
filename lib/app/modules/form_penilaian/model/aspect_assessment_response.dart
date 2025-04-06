import 'package:mob_dev_wave_coach/app/modules/form_penilaian/model/aspect_assessment_model.dart';

class AssessmentAspectResponse {
  final bool success;
  final String message;
  final List<AssessmentAspect> data;

  AssessmentAspectResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AssessmentAspectResponse.fromJson(Map<String, dynamic> json) {
    return AssessmentAspectResponse(
      success: json['success'],
      message: json['message'],
      data:
          (json['data'] as List)
              .map((item) => AssessmentAspect.fromJson(item))
              .toList(),
    );
  }
}
