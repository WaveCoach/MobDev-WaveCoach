import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mob_dev_wave_coach/app/core/services/api_service.dart';
import 'package:mob_dev_wave_coach/app/core/utils/loading_helper.dart';
import 'package:mob_dev_wave_coach/app/modules/schedule_detail/model/schedule_detail_response.dart';

class ScheduleDetailController extends GetxController {
  final apiService = Get.find<ApiService>();

  final isLoading = false.obs;
  final scheduleResponse = Rxn<ScheduleResponse>();
  final name = ''.obs;

  @override
  void onInit() {
    super.onInit();
    name.value = GetStorage().read("name") ?? "";
    final id = Get.arguments['id'];
    fetchScheduleDetail(id);
  }

  Future<void> fetchScheduleDetail(int id) async {
    await wrapLoading(isLoading, () async {
      final response = await apiService.ScheduleDetail(id);

      if (response.statusCode == 200 && response.body != null) {
        scheduleResponse.value = ScheduleResponse.fromJson(response.body);
      } else {
        logError("fetch schedule detail", response.statusText);
        Get.snackbar("Error", "Failed to load schedule");
      }
    });
  }
}
