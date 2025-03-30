import 'package:get/get.dart';
import 'package:mob_dev_wave_coach/app/core/services/api_service.dart';
import 'package:mob_dev_wave_coach/app/modules/schedule/model/schedule_response.dart';
import 'package:get_storage/get_storage.dart';

class ScheduleController extends GetxController {
  var isLoading = false.obs;
  var scheduleList = <Schedule>[].obs;
  var name = ''.obs;
  final ApiService apiService = Get.find<ApiService>();

  @override
  void onInit() {
    final storage = GetStorage();
    final storedName = storage.read("name") ?? " ";
    name.value = storedName;

    fetchSchedules();
    super.onInit();
  }

  void fetchSchedules() async {
    try {
      isLoading(true);
      final response = await apiService.listSchedule();

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

  Future<void> refreshScheduleList() async {
    isLoading.value = true;
    try {
      fetchSchedules();
    } finally {
      isLoading.value = false;
    }
  }
}
