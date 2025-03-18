import 'package:get/get.dart';
import 'package:mob_dev_wave_coach/app/core/services/api_service.dart';
import 'package:mob_dev_wave_coach/app/modules/schedule/model/schedule_response.dart';

class ScheduleController extends GetxController {
  var isLoading = true.obs;
  var scheduleList = <Schedule>[].obs;
  final ApiService apiService = Get.find<ApiService>(); // Gunakan DI

  @override
  void onInit() {
    fetchSchedules();
    super.onInit();
  }

  void fetchSchedules() async {
    try {
      isLoading(true);
      final response = await apiService.listSchedule(); // Hapus parameter {}

      if (response.statusCode == 200 && response.body != null) {
        try {
          var scheduleResponse = ScheduleResponse.fromJson(response.body);
          scheduleList.assignAll(scheduleResponse.data.schedule);
        } catch (e) {
          Get.snackbar("Error", "Invalid response format");
        }
      } else {
        Get.snackbar(
          "Error",
          "Failed to load schedules: ${response.statusText}",
        );
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoading(false);
    }
  }
}
