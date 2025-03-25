class ScheduleDetail {
  final int id;
  final String date, startTime, endTime, status, formattedDate;
  final Location? location;
  final Coach? coach;
  final List<Student> students;

  ScheduleDetail({
    required this.id,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.formattedDate,
    this.location,
    this.coach,
    required this.students,
  });

  factory ScheduleDetail.fromJson(Map<String, dynamic> json) {
    return ScheduleDetail(
      id: json['id'] as int,
      date: json['date'] as String,
      startTime: json['start_time'] as String,
      endTime: json['end_time'] as String,
      status: json['status'] as String,
      formattedDate: json['formatted_date'] as String,
      location:
          json['location'] != null ? Location.fromJson(json['location']) : null,
      coach: json['coach'] != null ? Coach.fromJson(json['coach']) : null,
      students:
          (json['students'] as List?)
              ?.map((s) => Student.fromJson(s))
              .toList() ??
          [],
    );
  }
}

class Location {
  final String name, address, maps;
  Location({required this.name, required this.address, required this.maps});

  factory Location.fromJson(Map<String, dynamic>? json) {
    return Location(
      name: json?['name'] as String? ?? '',
      address: json?['address'] as String? ?? '',
      maps: json?['maps'] as String? ?? '',
    );
  }
}

class Coach {
  final int id;
  final String name;
  final String? attendanceStatus;
  Coach({required this.id, required this.name, this.attendanceStatus});

  factory Coach.fromJson(Map<String, dynamic>? json) {
    return Coach(
      id: json?['id'] as int? ?? 0,
      name: json?['name'] as String? ?? 'Unknown',
      attendanceStatus: json?['attendance_status'] as String?,
    );
  }
}

class Student {
  final int id;
  final String name;
  final String? attendanceStatus;
  Student({required this.id, required this.name, this.attendanceStatus});

  factory Student.fromJson(Map<String, dynamic>? json) {
    return Student(
      id: json?['id'] as int? ?? 0,
      name: json?['name'] as String? ?? 'Unknown',
      attendanceStatus: json?['attendance_status'] as String?,
    );
  }
}
