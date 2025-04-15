import 'package:mob_dev_wave_coach/app/modules/detail_history_pengajuan/model/history_return_model.dart';

class HistoryInventoryReturnResponse {
  final bool success;
  final String message;
  final InventoryReturn data;

  HistoryInventoryReturnResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory HistoryInventoryReturnResponse.fromJson(Map<String, dynamic> json) {
    return HistoryInventoryReturnResponse(
      success: json['success'],
      message: json['message'],
      data: InventoryReturn.fromJson(json['data']),
    );
  }
}
