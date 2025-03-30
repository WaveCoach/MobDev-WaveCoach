import 'package:get/get.dart';

import '../controllers/detail_inventaris_controller.dart';

class DetailInventarisBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailInventarisController>(
      () => DetailInventarisController(),
    );
  }
}
