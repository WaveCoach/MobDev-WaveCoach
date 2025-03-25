import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mob_dev_wave_coach/app/core/services/api_service.dart';
import 'package:mob_dev_wave_coach/app/modules/schedule_detail/model/schedule_detail_model.dart';

class ScheduleDetailController extends GetxController {
  var isLoading = false.obs;
  var scheduleDetail = Rxn<ScheduleDetail>();
  final apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    fetchScheduleDetail(Get.arguments['id'] as int);
  }

  Future<void> fetchScheduleDetail(int id) async {
    isLoading(true);
    final response = await apiService.ScheduleDetail(id);
    debugPrint("📨 API Response: ${response.body}");

    if (response.statusCode == 200) {
      final scheduleData = response.body['data']?['schedule'];
      if (scheduleData is Map<String, dynamic>) {
        scheduleDetail.value = ScheduleDetail.fromJson(scheduleData);
      } else {
        debugPrint("⚠️ No valid schedule data found.");
      }
    }
    isLoading(false);
  }
}
