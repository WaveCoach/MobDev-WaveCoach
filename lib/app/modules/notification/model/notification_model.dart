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

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? 0,
      notifiableType: json['notifiable_type'] ?? '',
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      isRead: (json['is_read'] ?? 0) == 1,
      type: json['type'] ?? '',
      createdAt: json['created_at'] ?? '',
      user: User.fromJson(json['user'] ?? {}),
      pengirim: User.fromJson(json['pengirim'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'notifiable_type': notifiableType,
      'title': title,
      'message': message,
      'is_read': isRead ? 1 : 0,
      'type': type,
      'created_at': createdAt,
      'user': user.toJson(),
      'pengirim': pengirim.toJson(),
    };
  }
}

class User {
  final int id;
  final String name;

  User({required this.id, required this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['id'] ?? 0, name: json['name'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
