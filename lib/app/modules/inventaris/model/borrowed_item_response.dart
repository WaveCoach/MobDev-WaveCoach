import 'package:mob_dev_wave_coach/app/modules/inventaris/model/borrowed_item_model.dart';

class BorrowedItemResponse {
  final bool success;
  final String message;
  final List<BorrowedItem> data;

  BorrowedItemResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory BorrowedItemResponse.fromJson(Map<String, dynamic> json) {
    return BorrowedItemResponse(
      success: json['success'],
      message: json['message'],
      data:
          (json['data'] as List)
              .map((item) => BorrowedItem.fromJson(item))
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
