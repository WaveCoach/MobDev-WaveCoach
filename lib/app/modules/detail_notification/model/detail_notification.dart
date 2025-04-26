class NotificationDetail {
  final bool success;
  final String message;
  final NotificationData data;

  NotificationDetail({
    required this.success,
    required this.message,
    required this.data,
  });

  factory NotificationDetail.fromJson(Map<String, dynamic> json) {
    return NotificationDetail(
      success: json['success'],
      message: json['message'],
      data: NotificationData.fromJson(json['data']),
    );
  }
}

class NotificationData {
  final int id;
  final int notifiableId;
  final String notifiableType;
  final String title;
  final String message;
  final String createdAt;
  final int isRead;
  final String type;
  final User user;
  final User pengirim;
  final dynamic items; // bisa map atau list

  NotificationData({
    required this.id,
    required this.notifiableId,
    required this.notifiableType,
    required this.title,
    required this.message,
    required this.createdAt,
    required this.isRead,
    required this.type,
    required this.user,
    required this.pengirim,
    required this.items,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      id: json['id'],
      notifiableId: json['notifiable_id'],
      notifiableType: json['notifiable_type'],
      title: json['title'],
      message: json['message'],
      createdAt: json['created_at'],
      isRead: json['is_read'],
      type: json['type'],
      user: User.fromJson(json['user']),
      pengirim: User.fromJson(json['pengirim']),
      items: json['items'],
    );
  }
}

class User {
  final int id;
  final String name;

  User({required this.id, required this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['id'], name: json['name']);
  }
}
