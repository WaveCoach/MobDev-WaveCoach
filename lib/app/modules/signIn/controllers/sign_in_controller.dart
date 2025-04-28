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
  var obscurePassword = true.obs;

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  Future<void> signIn() async {
    isLoading.value = true;

    final body = {
      "email": emailController.text.trim(),
      "password": passwordController.text.trim(),
    };

    final response = await apiService.signIn(body);
    isLoading.value = false;

    if (response.status.isOk) {
      signInResponse.value = SignInResponse.fromJson(response.body);

      if (signInResponse.value?.success == true) {
        final user = signInResponse.value!.user;
        // print("User ID: ${user.id}");
        // print("User Name: ${user.name}");
        // print("User Email: ${user.email}");
        // print("User Role ID: ${user.roleId}");
        // print("User Profile Image: ${user.profileImage}");
        // print("Token: ${signInResponse.value!.token}");
        // Pastikan nilai tidak null sebelum disimpan
        storage.write("user_id", user.id.toString()); //
        storage.write("token", signInResponse.value!.token ?? '');
        storage.write("name", user.name ?? '');
        storage.write("email", user.email ?? '');
        storage.write("profile_image", user.profileImage ?? '');
        storage.write("roleId", user.roleId.toString());

        Get.offAllNamed(Routes.HOME);
      } else {
        Get.snackbar(
          "Sign In Failed",
          signInResponse.value?.message ?? "An error occurred during sign in",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } else {
      Get.snackbar(
        "Sign In Failed",
        "An error occurred during sign in",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
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
