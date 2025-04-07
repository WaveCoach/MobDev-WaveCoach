class Schedule {
  final int id;
  final String date;
  final String startTime;
  final String endTime;
  final String status;
  final String formattedDate;
  final String? package;

  Schedule({
    required this.id,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.formattedDate,
    this.package,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'],
      date: json['date'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      status: json['status'],
      formattedDate: json['formatted_date'],
      package: json['package'],
    );
  }
}

class Location {
  final String name;
  final String address;
  final String maps;

  Location({required this.name, required this.address, required this.maps});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'],
      address: json['address'],
      maps: json['maps'],
    );
  }
}

class Coach {
  final int id;
  final String name;
  final String? attendanceStatus;

  Coach({required this.id, required this.name, this.attendanceStatus});

  factory Coach.fromJson(Map<String, dynamic> json) {
    return Coach(
      id: json['id'],
      name: json['name'],
      attendanceStatus: json['attendance_status'],
    );
  }
}

class Student {
  final int id;
  final String name;
  final String? attendanceStatus;

  Student({required this.id, required this.name, this.attendanceStatus});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      name: json['name'],
      attendanceStatus: json['attendance_status'],
    );
  }
}
