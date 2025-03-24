class ScheduleDetail {
  final Schedule schedule;
  final Location location;
  final Coach coach;
  final List<Student> students;

  ScheduleDetail({
    required this.schedule,
    required this.location,
    required this.coach,
    required this.students,
  });

  factory ScheduleDetail.fromJson(Map<String, dynamic> json) {
    return ScheduleDetail(
      schedule: Schedule.fromJson(json['schedule']),
      location: Location.fromJson(json['location']),
      coach: Coach.fromJson(json['coach']),
      students:
          (json['students'] as List).map((s) => Student.fromJson(s)).toList(),
    );
  }
}

class Schedule {
  final int id;
  final String date;
  final String startTime;
  final String endTime;
  final String status;
  final String formattedDate;

  Schedule({
    required this.id,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.formattedDate,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'],
      date: json['date'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      status: json['status'],
      formattedDate: json['formatted_date'],
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
