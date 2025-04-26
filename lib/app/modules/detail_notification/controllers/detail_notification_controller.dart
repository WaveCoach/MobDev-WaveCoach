import 'package:get/get.dart';
import 'package:mob_dev_wave_coach/app/core/services/api_service.dart';
import 'package:mob_dev_wave_coach/app/core/utils/loading_helper.dart';
import 'package:mob_dev_wave_coach/app/modules/detail_notification/model/detail_notification.dart';

class DetailNotificationController extends GetxController {
  final ApiService apiService = Get.find<ApiService>();
  final isLoading = false.obs;
  final notificationDetail = Rx<NotificationDetail?>(null);

  late final int notificationId;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>;
    notificationId = args['id'];
    fetchNotificationDetail(notificationId);
  }

  Future<void> fetchNotificationDetail(int id) async {
    await wrapLoading(isLoading, () async {
      final response = await apiService.getNotificationDetail(id);

      if (response.statusCode == 200 && response.body != null) {
        final data = NotificationDetail.fromJson(response.body);
        notificationDetail.value = data;
      } else {
        logError("fetch notification detail", response.statusText);
        Get.snackbar("Error", "Failed to load notification details");
      }
    });
  }
}
