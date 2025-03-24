import 'package:get/get.dart';
import 'package:mob_dev_wave_coach/app/core/services/api_service.dart';
import 'package:mob_dev_wave_coach/app/modules/schedule_detail/model/schedule_detail_model.dart';
import 'package:mob_dev_wave_coach/app/modules/schedule_detail/model/schedule_detail_response.dart';

class ScheduleDetailController extends GetxController {
  var isLoading = true.obs;
  var scheduleDetail = Rxn<ScheduleDetail>();
  final ApiService apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    int scheduleId = Get.arguments;
    fetchScheduleDetail(scheduleId);
  }

  Future<void> fetchScheduleDetail(int id) async {
    try {
      isLoading(true);
      final response = await apiService.ScheduleDetail(id);

      if (response.statusCode == 200) {
        var responseData = ScheduleDetailResponse.fromJson(response.body);
        scheduleDetail.value = responseData.data;
      } else {
        Get.snackbar('Error', 'Failed to fetch schedule details');
      }
    } catch (e) {
      isLoading(false);
    }
  }
}
