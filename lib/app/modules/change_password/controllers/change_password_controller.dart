import 'package:get/get.dart';
import 'package:mob_dev_wave_coach/app/core/services/api_service.dart';
import 'package:mob_dev_wave_coach/app/modules/home/views/home_view.dart';

class ChangePasswordController extends GetxController {
  final ApiService apiService = ApiService();

  Future<void> sendChangePassword(
    String currentPassword,
    String newPassword,
    String confirmPassword,
  ) async {
    try {
      var response = await apiService.changePassword({
        "current_password": currentPassword,
        "new_password": newPassword,
        "new_password_confirmation": confirmPassword,
      });

      if (response.status.isOk) {
        Get.snackbar("Success", "Password changed successfully");
        Get.offAll(() => HomeView(), arguments: 3);
      } else {
        Get.snackbar(
          "Error",
          "Failed to change password: ${response.body?['message'] ?? 'Unknown error'}",
        );
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    }
  }
}
