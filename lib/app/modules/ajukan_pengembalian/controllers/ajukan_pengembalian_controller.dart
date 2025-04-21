import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mob_dev_wave_coach/app/core/services/api_service.dart';
import 'package:mob_dev_wave_coach/app/core/utils/loading_helper.dart';
import 'package:mob_dev_wave_coach/app/modules/ajukan_pengembalian/model/detail_pinjaman_inventaris_model.dart';

class AjukanPengembalianController extends GetxController {
  final apiService = Get.find<ApiService>();

  final isLoading = false.obs;
  final detailPinjaman = Rxn<InventoryLandingDetail>();
  final landingId = Rx<int?>(
    null,
  ); // Define landingId as an observable variable

  final qtyReturnedController = TextEditingController();
  final damagedController = TextEditingController();
  final missingController = TextEditingController();
  final returnedAtController = TextEditingController();

  final selectedImage = Rx<File?>(null); // Jika memakai File
  final isDamaged = false.obs;
  final isMissing = false.obs;

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
        print(detailPinjaman.value.toString());
      } else {
        log("fetch detail pinjaman error: ${response.statusText}");
        Get.snackbar("Error", "Gagal memuat detail pinjaman");
      }
    });
  }

  // Fungsi untuk konversi gambar ke base64
  Future<String?> imageToBase64(File image) async {
    try {
      final bytes = await image.readAsBytes();
      final base64Image = base64Encode(bytes);
      final ext = image.path.split('.').last.toLowerCase();

      final mime =
          ext == 'png'
              ? 'image/png'
              : ext == 'jpg' || ext == 'jpeg'
              ? 'image/jpeg'
              : 'application/octet-stream';

      return 'data:$mime;base64,$base64Image';
    } catch (e) {
      Get.snackbar("Error", "Gagal mengonversi gambar: $e");
      return null;
    }
  }

  Future<bool> submitReturnRequest(int landingId) async {
    try {
      final qtyReturned = int.tryParse(qtyReturnedController.text) ?? 0;
      final damagedCount = int.tryParse(damagedController.text) ?? 0;
      final missingCount = int.tryParse(missingController.text) ?? 0;
      final returnedAt = returnedAtController.text;

      String? base64Image;
      if (selectedImage.value != null) {
        base64Image = await imageToBase64(selectedImage.value!);
      }

      final payload = {
        "qty_returned": qtyReturned,
        "damaged_count": damagedCount,
        "missing_count": missingCount,
        "returned_at": returnedAt,
        if (base64Image != null) "img": base64Image,
      };

      final response = await apiService.postRequestReturn(landingId, payload);

      if (response.status.isOk) {
        Get.snackbar("Sukses", "Pengajuan pengembalian berhasil");
        return true; // Berhasil
      } else {
        Get.snackbar("Gagal", response.body?['message'] ?? "Pengajuan gagal");
        return false; // Gagal
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e");
      return false; // Gagal karena error
    }
  }

  @override
  void onClose() {
    qtyReturnedController.dispose();
    damagedController.dispose();
    missingController.dispose();
    returnedAtController.dispose();
    super.onClose();
  }
}
