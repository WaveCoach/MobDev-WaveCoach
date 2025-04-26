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
  final unreadNotificationCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    name.value = GetStorage().read("name") ?? "";
    fetchSchedules();
    fetchNotificationCount();
  }

  Future<void> fetchSchedules({bool? history}) async {
    await wrapLoading(isLoading, () async {
      final response = await apiService.listSchedule(history: history);

      if (response.statusCode == 200 && response.body != null) {
        final data = ScheduleResponse.fromJson(response.body).data.schedule;
        scheduleList.value = data;
      } else {
        logError("fetch schedules", response.statusText);
        Get.snackbar("Error", "Failed to load schedules");
      }
    });
  }

  Future<void> fetchNotificationCount() async {
    await wrapLoading(isLoading, () async {
      final response = await apiService.getCountNotification();

      if (response.statusCode == 200 && response.body != null) {
        final data = response.body['data']['unread_count'];
        unreadNotificationCount.value = data;
      } else {
        logError("fetch notification count", response.statusText);
        Get.snackbar("Error", "Failed to load notification count");
      }
    });
  }

  Future<void> refreshNotificationCount() async {
    await fetchNotificationCount();
  }

  Future<void> refreshScheduleList() async {
    await fetchSchedules();
  }
}
