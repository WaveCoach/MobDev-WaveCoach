import 'package:get/get.dart';
import 'package:mob_dev_wave_coach/app/core/services/api_service.dart';
import 'package:mob_dev_wave_coach/app/modules/schedule_detail/model/schedule_detail_response.dart';

class PresenceStudentController extends GetxController {
  final ApiService apiService = ApiService();
  var studentResponse = Rxn<ScheduleResponse>();
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    int scheduleId = Get.arguments['scheduleId'];
    print("Schedule ID: $scheduleId");
    fetchStudentList(scheduleId);
  }

  void fetchStudentList(int id) async {
    isLoading.value = true;
    final response = await apiService.ScheduleDetail(id);
    if (response.status.hasError) {
      isLoading.value = false;
      Get.snackbar("Error", "Failed to load schedule");
    } else {
      studentResponse.value = ScheduleResponse.fromJson(response.body);
      isLoading.value = false;
    }
  }

  Future<void> submitPresenceStudent(
    List<Map<String, dynamic>> studentAttendance,
  ) async {
    final Map<String, dynamic> requestBody = {
      "schedule_id": Get.arguments['scheduleId'],
      "student_attendance": studentAttendance,
    };

    print(requestBody.toString());

    try {
      final response = await apiService.absensiStudent(requestBody);
      if (response.statusCode == 201) {
        final responseData = response.body;
        Get.snackbar("Success", "Absensi berhasil 😃: ${responseData['data']}");
        Get.offNamed(
          '/schedule-detail',
          arguments: {'scheduleId': Get.arguments['scheduleId']},
        );
      } else {
        Get.snackbar("Error", "Gagal submit absensi: ${response.body}");
      }
    } catch (error) {
      print("Error: $error");
    }
  }
}
