class ScheduleDetail {
  final int id;
  final String date;
  final String startTime;
  final String endTime;
  final String status;
  final String formattedDate;
  final String coachName;
  final String locationName;
  final String locationAddress;
  final String locationMaps;

  ScheduleDetail({
    required this.id,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.formattedDate,
    required this.coachName,
    required this.locationName,
    required this.locationAddress,
    required this.locationMaps,
  });

  factory ScheduleDetail.fromJson(Map<String, dynamic> json) {
    return ScheduleDetail(
      id: json['id'],
      date: json['date'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      status: json['status'],
      formattedDate: json['formatted_date'],
      coachName: json['coach_name'],
      locationName: json['location_name'],
      locationAddress: json['location_address'],
      locationMaps: json['location_maps'],
    );
  }
}

// Model untuk Student
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
