import 'borrowing_data.dart';

class BorrowingResponse {
  final bool success;
  final String message;
  final List<BorrowingData> data;

  BorrowingResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory BorrowingResponse.fromJson(Map<String, dynamic> json) {
    return BorrowingResponse(
      success: json['success'],
      message: json['message'],
      data:
          (json['data'] as List)
              .map((item) => BorrowingData.fromJson(item))
              .toList(),
    );
  }
}
