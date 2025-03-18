import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:mob_dev_wave_coach/app/core/services/api_service.dart';
import 'package:mob_dev_wave_coach/app/routes/app_pages.dart';
import '../model/sign_in_response.dart';

class SignInController extends GetxController {
  final ApiService apiService = ApiService();
  final storage = GetStorage();
  var isLoading = false.obs;
  var signInResponse = Rx<SignInResponse?>(null);
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> signIn() async {
    isLoading.value = true;

    final body = {
      "email": emailController.text.trim(),
      "password": passwordController.text.trim(),
    };

    final url = "${apiService.baseUrl}/login";

    // Debugging: Cek URL & Body sebelum request
    print("🚀 Sending Request...");
    print("🔗 URL: $url");
    print("📦 Body: $body");

    final response = await apiService.signIn(body);

    isLoading.value = false;
    print("✅ Status Code: ${response.statusCode}");
    print("📝 Response Body: ${response.body}");

    if (response.status.isOk) {
      signInResponse.value = SignInResponse.fromJson(response.body);

      if (signInResponse.value?.success == true) {
        String token = signInResponse.value!.token;
        storage.write("token", token);

        // Redirect ke Home setelah login
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.snackbar(
          "Error",
          signInResponse.value?.message ?? "Sign In Failed",
        );
      }
    } else {
      Get.snackbar(
        "Error",
        "Sign In Failed",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
