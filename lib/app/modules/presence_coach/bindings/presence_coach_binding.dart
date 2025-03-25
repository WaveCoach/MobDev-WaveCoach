import 'package:get/get.dart';

import '../controllers/presence_coach_controller.dart';

class PresenceCoachBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PresenceCoachController>(
      () => PresenceCoachController(),
    );
  }
}
