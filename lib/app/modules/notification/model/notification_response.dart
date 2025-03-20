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
      success: map['success'],
      message: map['message'],
      notifications: List<NotificationModel>.from(
        map['data'].map((x) => NotificationModel.fromMap(x)),
      ),
    );
  }
}
