class User {
  final int id;
  final String name;
  final String email;
  final String? emailVerifiedAt;
  final String profileImage;
  final String? noTelf;
  final String createdAt;
  final String updatedAt;
  final int roleId;
  final String? deletedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.profileImage,
    required this.noTelf,
    required this.createdAt,
    required this.updatedAt,
    required this.roleId,
    required this.deletedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'],
      profileImage: json['profile_image'],
      noTelf: json['no_telf'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      roleId: json['role_id'],
      deletedAt: json['deleted_at'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'email_verified_at': emailVerifiedAt,
    'profile_image': profileImage,
    'no_telf': noTelf,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'role_id': roleId,
    'deleted_at': deletedAt,
  };
}
