import 'package:get/get.dart';

import '../controllers/detail_notification_controller.dart';

class DetailNotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailNotificationController>(
      () => DetailNotificationController(),
    );
  }
}
