class Admin {
  final int id;
  final String name;
  final String email;
  final String? profileImage;
  final String? noTelf;
  final int roleId;

  Admin({
    required this.id,
    required this.name,
    required this.email,
    this.profileImage,
    this.noTelf,
    required this.roleId,
  });

  factory Admin.fromMap(Map<String, dynamic> map) {
    return Admin(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      profileImage: map['profile_image'],
      noTelf: map['no_telf'],
      roleId: map['role_id'],
    );
  }
}
