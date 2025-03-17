import 'package:get/get.dart';
import 'package:mob_dev_wave_coach/app/routes/app_pages.dart';

class SplashScreenController extends GetxController {
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    print("SplashScreenController onInit() called");
    Future.delayed(Duration(seconds: 3), () {
      print("🔄 Navigating to Home...");
      Get.offAllNamed(Routes.HOME);
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
