import 'package:get/get.dart';
import 'package:mob_dev_wave_coach/app/core/services/api_service.dart';

class NotificationController extends GetxController {
  var isLoading = true.obs;
  var notificationList = [].obs;
  final ApiService apiService = Get.find<ApiService>();

  @override
  void onInit() {
    fetchNotifications();
    super.onInit();
  }

  void fetchNotifications() async {
    try {
      isLoading(true);
      final response = await apiService.listNotification();

      if (response.statusCode == 200 && response.body != null) {
        try {
          notificationList.assignAll(response.body);
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
}
