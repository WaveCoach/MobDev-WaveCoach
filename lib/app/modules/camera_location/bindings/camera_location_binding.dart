import 'package:get/get.dart';

import '../controllers/camera_location_controller.dart';

class CameraLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CameraLocationController>(
      () => CameraLocationController(),
    );
  }
}
