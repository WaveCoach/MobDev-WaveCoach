import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mob_dev_wave_coach/app/core/services/api_service.dart';
import 'package:mob_dev_wave_coach/app/core/utils/loading_helper.dart';
import 'package:mob_dev_wave_coach/app/modules/ajukan_pengembalian/model/detail_pinjaman_inventaris_model.dart';

class AjukanPengembalianController extends GetxController {
  final apiService = Get.find<ApiService>();

  final isLoading = false.obs;
  final detailPinjaman = Rxn<InventoryLandingDetail>();
  RxString selectedImage = ''.obs;
  final isDamaged = false.obs;
  final damagedCountController = TextEditingController();
  final isMissing = false.obs;
  final missingCountController = TextEditingController();
  final returnDateController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;
    final id = args['landingId'];
    fetchDetailPinjaman(id);
  }

  Future<void> fetchDetailPinjaman(int id) async {
    await wrapLoading(isLoading, () async {
      final response = await apiService.getDetailInventoryLanding(id);

      if (response.statusCode == 200 && response.body != null) {
        detailPinjaman.value = InventoryLandingDetail.fromJson(
          response.body['data'],
        );
      } else {
        logError("fetch detail pinjaman", response.statusText);
        Get.snackbar("Error", "Gagal memuat detail pinjaman");
      }
    });
  }
}
