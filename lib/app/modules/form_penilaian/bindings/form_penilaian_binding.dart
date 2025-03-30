import 'package:get/get.dart';

import '../controllers/form_penilaian_controller.dart';

class FormPenilaianBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FormPenilaianController>(
      () => FormPenilaianController(),
    );
  }
}
