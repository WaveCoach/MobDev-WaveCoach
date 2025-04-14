import 'package:get/get.dart';

import '../controllers/detail_history_pengajuan_controller.dart';

class DetailHistoryPengajuanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailHistoryPengajuanController>(
      () => DetailHistoryPengajuanController(),
    );
  }
}
