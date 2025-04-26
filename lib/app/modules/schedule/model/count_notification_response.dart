class NotificationResponse {
  bool success;
  String message;
  NotificationData data;

  NotificationResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    return NotificationResponse(
      success: json['success'],
      message: json['message'],
      data: NotificationData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'data': data.toJson()};
  }
}

class NotificationData {
  int unreadCount;

  NotificationData({required this.unreadCount});

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(unreadCount: json['unread_count']);
  }

  Map<String, dynamic> toJson() {
    return {'unread_count': unreadCount};
  }
}
