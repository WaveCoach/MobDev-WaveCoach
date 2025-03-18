import 'package:get/get.dart';

class ApiService extends GetConnect {
  final String url = "https://wavecoach.cintaramayanti.com/api";

  Future<Response> signIn(Map<String, dynamic> body) {
    return post(
      "$url/login",
      body,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
    );
  }
}
