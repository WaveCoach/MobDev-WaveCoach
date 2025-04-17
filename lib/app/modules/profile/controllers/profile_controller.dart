import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mob_dev_wave_coach/app/modules/profile/model/profile_response.dart';

import '../../../core/services/api_service.dart';
import '../../../core/utils/loading_helper.dart';

class ProfileController extends GetxController {
  final apiService = Get.find<ApiService>();
  final box = GetStorage();

  final imageController = TextEditingController();

  final name = ''.obs;
  final email = ''.obs;
  final imageUrl = ''.obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  Future<void> getProfile() async {
    await wrapLoading(isLoading, () async {
      final response = await apiService.getProfile();

      if (response.statusCode == 200) {
        final responseData = UserProfileResponse.fromJson(response.body);
        final user = responseData.data.user;

        // Fallback jika null
        name.value = user.name;
        email.value = user.email;
        imageUrl.value = user.profileImage;

        imageController.text = imageUrl.value;
      } else {
        logError("Get profile", "${response.statusCode}: ${response.body}");

        Get.snackbar(
          "Error",
          "Gagal mendapatkan profil: ${response.body}",
          snackPosition: SnackPosition.TOP,
        );
      }
    });
  }

  Future<void> updateProfile() async {
    final image = imageController.text.trim();

    if (image.isEmpty) {
      Get.snackbar(
        "Error",
        "Gambar tidak boleh kosong",
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    await wrapLoading(isLoading, () async {
      final response = await apiService.updateProfile({"image": image});

      if (response.statusCode == 200) {
        imageUrl.value = image;
        Get.snackbar(
          "Sukses",
          "Foto profil diperbarui",
          snackPosition: SnackPosition.TOP,
        );
      } else {
        final body = response.body;
        Get.snackbar(
          "Gagal",
          "Gagal update: ${body['error'] ?? response.body}",
          snackPosition: SnackPosition.TOP,
        );
      }
    });
  }

  void logout() {
    box.remove('token');
    Get.offAllNamed('/sign-in');
  }

  @override
  void onClose() {
    imageController.dispose();
    super.onClose();
  }

  @override
  void dispose() {
    imageController.dispose();
    super.dispose();
  }
}
