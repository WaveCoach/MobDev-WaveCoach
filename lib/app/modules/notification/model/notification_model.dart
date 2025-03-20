class NotificationModel {
  final int id;
  final String notifiableType;
  final String title;
  final String message;
  final bool isRead;
  final String type;
  final String createdAt;
  final User user;
  final User pengirim;

  NotificationModel({
    required this.id,
    required this.notifiableType,
    required this.title,
    required this.message,
    required this.isRead,
    required this.type,
    required this.createdAt,
    required this.user,
    required this.pengirim,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] ?? 0,
      notifiableType: map['notifiable_type'] ?? '',
      title: map['title'] ?? '',
      message: map['message'] ?? '',
      isRead: (map['is_read'] ?? 0) == 1,
      type: map['type'] ?? '',
      createdAt: map['created_at'] ?? '',
      user: User.fromMap(map['user'] ?? {}),
      pengirim: User.fromMap(map['pengirim'] ?? {}),
    );
  }
}

class User {
  final int id;
  final String name;

  User({required this.id, required this.name});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(id: map['id'] ?? 0, name: map['name'] ?? '');
  }
}
