import 'package:get/get.dart';

import '../controllers/ajukan_peminjaman_controller.dart';

class AjukanPeminjamanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AjukanPeminjamanController>(
      () => AjukanPeminjamanController(),
    );
  }
}
