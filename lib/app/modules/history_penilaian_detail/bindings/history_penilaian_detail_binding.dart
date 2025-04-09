import 'package:get/get.dart';

import '../controllers/history_penilaian_detail_controller.dart';

class HistoryPenilaianDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistoryPenilaianDetailController>(
      () => HistoryPenilaianDetailController(),
    );
  }
}
