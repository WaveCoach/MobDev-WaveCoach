class MasterCoach {
  final int id;
  final String name;

  MasterCoach({required this.id, required this.name});

  factory MasterCoach.fromJson(Map<String, dynamic> json) {
    return MasterCoach(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
