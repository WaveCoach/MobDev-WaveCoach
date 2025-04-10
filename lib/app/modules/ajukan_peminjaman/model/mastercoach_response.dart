import 'package:mob_dev_wave_coach/app/modules/ajukan_peminjaman/model/mastercoach_model.dart';

class MasterCoachResponse {
  final bool success;
  final String message;
  final List<MasterCoach> data;

  MasterCoachResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory MasterCoachResponse.fromJson(Map<String, dynamic> json) {
    return MasterCoachResponse(
      success: json['success'],
      message: json['message'],
      data: List<MasterCoach>.from(
        json['data'].map((x) => MasterCoach.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.map((x) => x.toJson()).toList(),
    };
  }
}
