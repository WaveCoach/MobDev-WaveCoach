import 'package:get/get.dart';

import '../controllers/form_ajuan_pengembalian_controller.dart';

class FormAjuanPengembalianBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FormAjuanPengembalianController>(
      () => FormAjuanPengembalianController(),
    );
  }
}
