import 'notification_model.dart';

class NotificationResponse {
  final bool success;
  final String message;
  final List<NotificationModel> notifications;

  NotificationResponse({
    required this.success,
    required this.message,
    required this.notifications,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    return NotificationResponse(
      success: json['success'] ?? false, // Default false kalau null
      message: json['message'] ?? '', // Default string kosong kalau null
      notifications:
          (json['data'] as List?)
              ?.map((item) => NotificationModel.fromJson(item))
              .toList() ??
          [], // Kalau json['data'] null, gunakan list kosong []
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': notifications.map((notif) => notif.toJson()).toList(),
    };
  }
}
