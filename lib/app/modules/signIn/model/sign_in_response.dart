class SignInResponse {
  final bool success;
  final String message;
  final String token;
  final User user;

  SignInResponse({
    required this.success,
    required this.message,
    required this.token,
    required this.user,
  });

  factory SignInResponse.fromJson(Map<String, dynamic> json) {
    return SignInResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? 'Unknown error',
      token: json['data']?['token'] ?? '',
      user:
          json['data']?['user'] != null
              ? User.fromJson(json['data']['user'])
              : User(id: 0, name: '', email: '', roleId: 0),
    );
  }
}

class User {
  final int id;
  final String name;
  final String email;
  final int roleId;
  final String? profileImage;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.roleId,
    this.profileImage,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      roleId: json['role_id'] ?? 0,
      profileImage: json['profile_image'],
    );
  }
}
