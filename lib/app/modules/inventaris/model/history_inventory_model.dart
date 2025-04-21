class HistoryData {
  int id;
  int mastercoachId;
  int coachId;
  String status;
  String createdAt;
  String updatedAt;
  String type;
  String coachName;
  String? imageUrlHistory;
  String? condition;

  HistoryData({
    required this.id,
    required this.mastercoachId,
    required this.coachId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
    required this.coachName,
    this.imageUrlHistory,
    this.condition,
  });

  factory HistoryData.fromJson(Map<String, dynamic> json) {
    return HistoryData(
      id: json['id'],
      mastercoachId: json['mastercoach_id'],
      coachId: json['coach_id'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      type: json['type'],
      coachName: json['coach_name'],
      imageUrlHistory: json['profile_image'] ?? null,
      condition: json['condition'] ?? null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'mastercoach_id': mastercoachId,
      'coach_id': coachId,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'type': type,
      'coach_name': coachName,
      'profile_image': imageUrlHistory,
      'condition': condition,
    };
  }
}
