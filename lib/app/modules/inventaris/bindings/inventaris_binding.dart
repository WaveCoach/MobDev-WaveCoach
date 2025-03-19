import 'package:get/get.dart';

import '../controllers/inventaris_controller.dart';

class InventarisBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InventarisController>(
      () => InventarisController(),
    );
  }
}
