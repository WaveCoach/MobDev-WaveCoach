import 'package:mob_dev_wave_coach/app/modules/detail_history_pengajuan/model/history_request_model.dart';

class HistoryInventoryRequestResponse {
  final bool success;
  final String message;
  final InventoryRequest data;

  HistoryInventoryRequestResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory HistoryInventoryRequestResponse.fromJson(Map<String, dynamic> json) {
    return HistoryInventoryRequestResponse(
      success: json['success'],
      message: json['message'],
      data: InventoryRequest.fromJson(json['data']),
    );
  }
}
