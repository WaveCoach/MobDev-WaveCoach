import 'package:get/get.dart';
import 'package:mob_dev_wave_coach/app/core/services/api_service.dart';
import 'package:mob_dev_wave_coach/app/modules/schedule_detail/controllers/schedule_detail_controller.dart';

class RescheduleController extends GetxController {
  final ApiService apiService = ApiService();

  Future<void> sendRescheduleRequest(String reason) async {
    try {
      var response = await apiService.reschedule({
        "schedule_id": Get.arguments['scheduleId'],
        "reason": reason,
      });

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 201) {
        Get.snackbar("Success", "Berhasil melakukan pengajuan reschedule");

        // Navigasi ke halaman schedule-detail
        Get.offNamed(
          '/schedule-detail',
          arguments: {'scheduleId': Get.arguments['scheduleId']},
        );

        // Refresh halaman schedule-detail
        final scheduleDetailController = Get.find<ScheduleDetailController>();
        scheduleDetailController.refreshSchedule();
      } else {
        Get.snackbar(
          "Error",
          "Gagal melakukan pengajuan reschedule karena sudah ada pengajuan sebelumnya",
        );
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    }
  }
}
