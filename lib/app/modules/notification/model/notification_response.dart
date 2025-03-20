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

  factory NotificationResponse.fromMap(Map<String, dynamic> map) {
    return NotificationResponse(
      success: map['success'] ?? false, // Default false kalau null
      message: map['message'] ?? '', // Default string kosong kalau null
      notifications:
          (map['data'] as List?)
              ?.map((x) => NotificationModel.fromMap(x))
              .toList() ??
          [],
      // Kalau map['data'] null, gunakan list kosong []
    );
  }
}
