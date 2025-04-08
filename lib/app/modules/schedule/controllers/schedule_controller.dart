import 'package:get/get.dart';
import 'package:mob_dev_wave_coach/app/core/services/api_service.dart';
import 'package:mob_dev_wave_coach/app/modules/schedule/model/schedule_response.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mob_dev_wave_coach/app/core/utils/loading_helper.dart';

class ScheduleController extends GetxController {
  final apiService = Get.find<ApiService>();

  final isLoading = false.obs;
  final scheduleList = <Schedule>[].obs;
  final name = ''.obs;

  @override
  void onInit() {
    super.onInit();
    name.value = GetStorage().read("name") ?? "";
    fetchSchedules();
  }

  Future<void> fetchSchedules() async {
    await wrapLoading(isLoading, () async {
      final response = await apiService.listSchedule();

      if (response.statusCode == 200 && response.body != null) {
        final data = ScheduleResponse.fromJson(response.body).data.schedule;
        scheduleList.value = data;
      } else {
        logError("fetch schedules", response.statusText);
        Get.snackbar("Error", "Failed to load schedules");
      }
    });
  }

  Future<void> refreshScheduleList() async {
    await fetchSchedules();
  }
}
