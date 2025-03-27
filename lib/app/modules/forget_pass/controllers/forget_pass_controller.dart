import 'package:get/get.dart';
import 'package:mob_dev_wave_coach/app/core/services/api_service.dart';

class ForgetPassController extends GetxController {
  final ApiService apiService = ApiService();
  var isLoading = false.obs;

  Future<void> sendResetPassword(String email) async {
    try {
      isLoading.value = true;
      final response = await apiService.forgetPassword({"email": email});

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Reset link sent to your email.");
      } else {
        Get.snackbar(
          "Error",
          response.body["message"] ?? "Something went wrong",
        );
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to send reset link.");
    } finally {
      isLoading.value = false;
    }
  }
}
