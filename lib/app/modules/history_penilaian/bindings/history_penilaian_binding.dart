import 'package:get/get.dart';

import '../controllers/history_penilaian_controller.dart';

class HistoryPenilaianBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistoryPenilaianController>(
      () => HistoryPenilaianController(),
    );
  }
}
