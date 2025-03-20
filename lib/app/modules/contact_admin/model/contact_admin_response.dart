import 'package:mob_dev_wave_coach/app/modules/contact_admin/model/contact_admin_model.dart';

class AdminResponse {
  final bool success;
  final String message;
  final List<Admin> admins;

  AdminResponse({
    required this.success,
    required this.message,
    required this.admins,
  });

  factory AdminResponse.fromMap(Map<String, dynamic> map) {
    return AdminResponse(
      success: map['success'],
      message: map['message'],
      admins: List<Admin>.from(map['data'].map((x) => Admin.fromMap(x))),
    );
  }
}
