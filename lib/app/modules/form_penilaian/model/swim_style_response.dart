import 'swim_style_model.dart';

class SwimStyleResponse {
  final bool success;
  final String message;
  final List<SwimStyle> data;

  SwimStyleResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory SwimStyleResponse.fromJson(Map<String, dynamic> json) {
    return SwimStyleResponse(
      success: json['success'],
      message: json['message'],
      data: List<SwimStyle>.from(
        json['data'].map((item) => SwimStyle.fromJson(item)),
      ),
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
