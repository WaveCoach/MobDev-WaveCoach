class ScheduleResponse {
  final bool success;
  final String message;
  final ScheduleData data;

  ScheduleResponse(this.success, this.message, this.data);

  ScheduleResponse.fromJson(Map<String, dynamic> json)
    : success = json["success"],
      message = json["message"],
      data = ScheduleData.fromJson(json["data"]);
}

class ScheduleData {
  final List<Schedule> schedule;
  ScheduleData(this.schedule);
  ScheduleData.fromJson(Map<String, dynamic> json)
    : schedule =
          (json["schedule"] as List).map((x) => Schedule.fromJson(x)).toList();
}

class Schedule {
  final int id;
  final String date, startTime, endTime, status, formattedDate;
  final String coachName, locationName, locationAddress, locationMaps;
  final int? packageId;
  final String? packageName;

  Schedule(
    this.id,
    this.date,
    this.startTime,
    this.endTime,
    this.status,
    this.formattedDate,
    this.coachName,
    this.locationName,
    this.locationAddress,
    this.locationMaps,
    this.packageId,
    this.packageName,
  );

  Schedule.fromJson(Map<String, dynamic> json)
    : id = json["id"],
      date = json["date"],
      startTime = json["start_time"],
      endTime = json["end_time"],
      status = json["status"],
      formattedDate = json["formatted_date"],
      coachName = json["coach_name"],
      locationName = json["location_name"],
      locationAddress = json["location_address"],
      locationMaps = json["location_maps"],
      packageId = json["package_id"],
      packageName = json["package_name"];
}
