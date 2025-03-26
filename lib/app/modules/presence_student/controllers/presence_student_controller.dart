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
    fetchStudentList(scheduleId);
  }

  void fetchStudentList(int id) async {
    isLoading.value = true;
    final response = await apiService.ScheduleDetail(id);
    if (response.status.hasError) {
      isLoading.value = false;
      Get.snackbar("Error", "Failed to load schedule");
    } else {
      print(
        "Response Body: ${response.body} 😃",
      ); // Debug response body with emoji
      studentResponse.value = ScheduleResponse.fromJson(response.body);
      isLoading.value = false;
    }
  }
}
