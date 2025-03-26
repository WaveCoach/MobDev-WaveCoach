import 'package:get/get.dart';
import 'package:mob_dev_wave_coach/app/core/services/api_service.dart';
import 'package:mob_dev_wave_coach/app/modules/schedule_detail/model/schedule_detail_response.dart';

class ScheduleDetailController extends GetxController {
  final ApiService apiService = ApiService();
  var scheduleResponse = Rxn<ScheduleResponse>();
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    int id = Get.arguments['id']; // Get the ID from aa
    print("ID: $id 😃"); // Debug ID with emoji
    fetchScheduleDetail(id);
  }

  void fetchScheduleDetail(int id) async {
    isLoading.value = true;
    final response = await apiService.ScheduleDetail(id);
    if (response.status.hasError) {
      isLoading.value = false;
      Get.snackbar("Error", "Failed to load schedule");
    } else {
      print(
        "Response Body: ${response.body} 😃",
      ); // Debug response body with emoji
      scheduleResponse.value = ScheduleResponse.fromJson(response.body);
      isLoading.value = false;
    }
  }
}
