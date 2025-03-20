import 'package:mob_dev_wave_coach/app/modules/inventaris/model/history_inventory_model.dart';

class HistoryInventoryResponse {
  bool success;
  String message;
  List<HistoryData> data;

  HistoryInventoryResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory HistoryInventoryResponse.fromJson(Map<String, dynamic> json) {
    return HistoryInventoryResponse(
      success: json['success'],
      message: json['message'],
      data: List<HistoryData>.from(
        json['data'].map((x) => HistoryData.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': List<dynamic>.from(data.map((x) => x.toJson())),
    };
  }
}
