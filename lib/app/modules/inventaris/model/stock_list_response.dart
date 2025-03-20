import 'stock_list_model.dart';

class StockListResponse {
  final bool success;
  final String message;
  final List<StockListModel> data;

  StockListResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory StockListResponse.fromJson(Map<String, dynamic> json) {
    return StockListResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data:
          (json['data'] as List?)
              ?.map((x) => StockListModel.fromJson(x))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.map((x) => x.toJson()).toList(),
    };
  }
}
