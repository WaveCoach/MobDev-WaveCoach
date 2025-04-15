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

  Future<Response> updateProfile(Map<String, dynamic> body) {
    return post("$url/update-profile", body, headers: getHeaders());
  }

  Future<Response> getProfile() {
    return get("$url/profile", headers: getHeaders());
  }

  Future<Response> listAdmin() {
    return get("$url/list-admin", headers: getHeaders(withAuth: false));
  }

  Future<Response> listSchedule({String? month, bool? history, String? date}) {
    String urlString = "$url/schedule";
    Map<String, String> queryParams = {};

    if (month != null) {
      queryParams['month'] = month;
    }
    if (history != null) {
      queryParams['history'] = history.toString();
    }
    if (date != null) {
      queryParams['date'] = date;
    }

    if (queryParams.isNotEmpty) {
      urlString += '?' + Uri(queryParameters: queryParams).query;
    }

    return get(urlString, headers: getHeaders());
  }

  Future<Response> ScheduleDetail(int id) {
    return get("$url/schedule/$id", headers: getHeaders());
  }

  Future<Response> listNotification() {
    return get("$url/notification", headers: getHeaders());
  }

  //melihat jumlah inventory stok yang dipegang mastercoach
  Future<Response> listStock() {
    return get("$url/daftarinventory", headers: getHeaders());
  }

  //melihat inventory yang dipinjam
  Future<Response> borrowedItem() {
    return get("$url/inventory-landing", headers: getHeaders());
  }

  //mengambil history inventaris
  Future<Response> historyPeminjamanInventaris({String? filter}) {
    final query =
        (filter != null && filter.toLowerCase() != 'semua')
            ? "?filter=${filter.toLowerCase()}"
            : "";

    return get("$url/request-history-inventory$query", headers: getHeaders());
  }

  Future<Response> absensiCoach(Map<String, dynamic> body) {
    return post("$url/absensi-coach", body, headers: getHeaders());
  }

  Future<Response> absensiStudent(Map<String, dynamic> body) {
    return post("$url/absensi-student", body, headers: getHeaders());
  }

  Future<Response> reschedule(Map<String, dynamic> body) {
    return post("$url/reschedule", body, headers: getHeaders());
  }

  Future<Response> forgetPassword(Map<String, dynamic> body) {
    return post(
      "$url/forgot-password",
      body,
      headers: getHeaders(withAuth: false),
    );
  }

  Future<Response> changePassword(Map<String, dynamic> body) {
    return post("$url/change-password", body, headers: getHeaders());
  }

  Future<Response> getStudentbySchedule(int scheduleId) {
    return get("$url/student-list/$scheduleId", headers: getHeaders());
  }

  Future<Response> getStyleSwim() {
    return get("$url/assesment-category", headers: getHeaders());
  }

  Future<Response> getStyleSwimAspect(int CategoryId) {
    return get("$url/assessment-aspect/$CategoryId", headers: getHeaders());
  }

  Future<Response> postAssessment(Map<String, dynamic> body) {
    return post("$url/post-assessment", body, headers: getHeaders());
  }

  Future<Response> getHistoryAssessment({String? search}) {
    String urlString = "$url/history-assessment";
    if (search != null && search.isNotEmpty) {
      urlString += "?search=$search";
    }
    return get(urlString, headers: getHeaders());
  }

  Future<Response> getDetailHistoryAssessment(int id) {
    return get("$url/history-assessment/$id", headers: getHeaders());
  }

  Future<Response> getMastercoach() {
    return get("$url/list-mastercoach-inventory", headers: getHeaders());
  }

  Future<Response> getInventoryManagementMastercoach(int mastercoachId) {
    return get("$url/inventory-list/$mastercoachId", headers: getHeaders());
  }

  Future<Response> postRequestBorrow(Map<String, dynamic> body) {
    return post("$url/request-loan", body, headers: getHeaders());
  }

  Future<Response> getDetailBorrowingList(int inventoryId) {
    return get("$url/inventory-landing/$inventoryId", headers: getHeaders());
  }

  Future<Response> getDetailRequest(int id) {
    return get("$url/inventory-request-history/$id", headers: getHeaders());
  }

  Future<Response> getDetailReturn(int id) {
    return get("$url/inventory-return-history/$id", headers: getHeaders());
  }
}
