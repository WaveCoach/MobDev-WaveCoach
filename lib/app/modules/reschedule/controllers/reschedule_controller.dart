import 'package:get/get.dart';
import 'package:mob_dev_wave_coach/app/core/services/api_service.dart';

class RescheduleController extends GetxController {
  final ApiService apiService = ApiService();

  Future<void> sendRescheduleRequest(String reason) async {
    try {
      var response = await apiService.reschedule({
        "schedule_id": Get.arguments['scheduleId'],
        "reason": reason,
      });

      print(response.toString());

      if (response.statusCode == 201) {
        Get.snackbar("Success", "Berhasil melakukan pengajuan reschedule");
        Get.offNamed(
          '/schedule-detail',
          arguments: {'scheduleId': Get.arguments['scheduleId']},
        );
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
