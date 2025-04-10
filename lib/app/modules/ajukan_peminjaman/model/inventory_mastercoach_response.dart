import 'package:mob_dev_wave_coach/app/modules/ajukan_peminjaman/model/inventory_matercoach_model.dart';

class InventoryResponse {
  final bool success;
  final String message;
  final List<InventoryItem> data;

  InventoryResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory InventoryResponse.fromJson(Map<String, dynamic> json) {
    return InventoryResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data:
          (json['data'] as List)
              .map((item) => InventoryItem.fromJson(item))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}
