import 'package:get/get.dart';
import 'package:mob_dev_wave_coach/app/core/services/api_service.dart';
import 'package:mob_dev_wave_coach/app/modules/schedule_detail/model/schedule_detail_model.dart';

class ScheduleDetailController extends GetxController {
  var isLoading = true.obs;
  var scheduleDetail = Rxn<ScheduleDetail>();
  final ApiService apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    int scheduleId = Get.arguments ?? 1;
    fetchScheduleDetail(scheduleId);
  }

  Future<void> fetchScheduleDetail(int id) async {
    try {
      isLoading(true);
      var response = await apiService.ScheduleDetail(id);
      if (response.statusCode == 200) {
        scheduleDetail.value = ScheduleDetail.fromJson(
          response.body['data']['schedule'],
        );
      } else {
        print("Failed to load schedule: ${response.statusText}");
      }
    } catch (e) {
      print("Error fetching schedule: $e");
    } finally {
      isLoading(false);
    }
  }
}
