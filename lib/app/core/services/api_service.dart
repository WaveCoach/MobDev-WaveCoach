import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ApiService extends GetConnect {
  final String url = "https://wavecoach.cintaramayanti.com/api";
  final storage = GetStorage();

  Map<String, String> getHeaders({bool withAuth = true}) {
    final token = storage.read("token");
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };

    if (withAuth && token != null) {
      headers["Authorization"] = "Bearer $token";
    }

    return headers;
  }

  Future<Response> signIn(Map<String, dynamic> body) {
    return post("$url/login", body, headers: getHeaders(withAuth: false));
  }

  Future<Response> listSchedule() {
    return get("$url/schedule", headers: getHeaders());
  }

  Future<Response> getScheduleDetail(int id) {
    return get("$url/schedule/$id", headers: getHeaders());
  }

  Future<Response> requestReschedule(Map<String, dynamic> body) {
    return post("$url/reschedule", body, headers: getHeaders());
  }

  Future<Response> listAdmin() {
    return get("$url/list-admin", headers: getHeaders(withAuth: false));
  }
}
