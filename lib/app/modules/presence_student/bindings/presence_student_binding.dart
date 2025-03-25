import 'package:get/get.dart';

import '../controllers/presence_student_controller.dart';

class PresenceStudentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PresenceStudentController>(
      () => PresenceStudentController(),
    );
  }
}
