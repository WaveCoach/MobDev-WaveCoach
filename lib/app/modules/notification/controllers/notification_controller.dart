import 'package:get/get.dart';
import 'package:mob_dev_wave_coach/app/core/services/api_service.dart';
import 'package:mob_dev_wave_coach/app/modules/notification/model/notification_model.dart';
import 'package:mob_dev_wave_coach/app/modules/notification/model/notification_response.dart';

class NotificationController extends GetxController {
  var isLoading = false.obs;
  var notificationList = <NotificationModel>[].obs;
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
          var notificationResponse = NotificationResponse.fromMap(
            response.body,
          );
          notificationList.assignAll(notificationResponse.notifications);
        } catch (e) {
          Get.snackbar("Error", "Invalid response format: $e");
        }
      } else {
        Get.snackbar(
          "Error",
          "Failed to load notifications: ${response.statusText}",
        );
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoading(false);
    }
  }
}
