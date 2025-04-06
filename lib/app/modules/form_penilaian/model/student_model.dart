class Student {
  final int id;
  final String name;

  Student({required this.id, required this.name});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(id: json['id'], name: json['name']);
  }

  @override
  String toString() {
    return 'Student{id: $id, name: $name}';
  }
}
