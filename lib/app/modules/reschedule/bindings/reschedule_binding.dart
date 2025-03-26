import 'package:get/get.dart';

import '../controllers/reschedule_controller.dart';

class RescheduleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RescheduleController>(
      () => RescheduleController(),
    );
  }
}
