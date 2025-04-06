import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mob_dev_wave_coach/app/core/services/api_service.dart';
import 'package:mob_dev_wave_coach/app/modules/schedule/controllers/schedule_controller.dart';
import 'package:mob_dev_wave_coach/app/modules/schedule/model/schedule_response.dart';

class FormPenilaianController extends GetxController {
  final ScheduleController scheduleController = Get.find<ScheduleController>();
  final TextEditingController dateController = TextEditingController();
  var isLoading = false.obs;
  var selectedSchedule = Rxn<Schedule>();
  final ApiService apiService = Get.find<ApiService>();

  Future<void> fetchSchedulesByDate({
    required String date,
    String? month,
    bool? history,
  }) async {
    try {
      isLoading.value = true;
      final response = await apiService.listSchedule(
        month: month,
        history: history,
        date: date,
      );

      if (response.statusCode == 200) {
        final decoded = response.body;
        final scheduleResponse = ScheduleResponse.fromJson(decoded);
        final scheduleList = scheduleResponse.data.schedule;

        scheduleController.scheduleList.value = scheduleList;
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching schedules: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    dateController.dispose();
    super.onClose();
  }
}
