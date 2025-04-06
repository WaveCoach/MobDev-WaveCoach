class SwimStyle {
  final int id;
  final String name;

  SwimStyle({required this.id, required this.name});

  factory SwimStyle.fromJson(Map<String, dynamic> json) {
    return SwimStyle(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
