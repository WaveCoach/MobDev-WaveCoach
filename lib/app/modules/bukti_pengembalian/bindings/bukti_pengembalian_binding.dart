import 'package:get/get.dart';

import '../controllers/bukti_pengembalian_controller.dart';

class BuktiPengembalianBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BuktiPengembalianController>(
      () => BuktiPengembalianController(),
    );
  }
}
