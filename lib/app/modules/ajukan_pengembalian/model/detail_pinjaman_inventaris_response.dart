import 'package:mob_dev_wave_coach/app/modules/ajukan_pengembalian/model/detail_pinjaman_inventaris_model.dart';

class InventoryLandingResponse {
  final bool success;
  final String message;
  final InventoryLandingDetail data;

  InventoryLandingResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory InventoryLandingResponse.fromJson(Map<String, dynamic> json) {
    return InventoryLandingResponse(
      success: json['success'],
      message: json['message'],
      data: InventoryLandingDetail.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'data': data.toJson()};
  }
}
