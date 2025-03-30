import 'package:get/get.dart';

import '../controllers/ajukan_pengembalian_controller.dart';

class AjukanPengembalianBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AjukanPengembalianController>(
      () => AjukanPengembalianController(),
    );
  }
}
