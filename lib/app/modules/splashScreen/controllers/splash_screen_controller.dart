import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mob_dev_wave_coach/app/routes/app_pages.dart';

class SplashScreenController extends GetxController {
  final storage = GetStorage();
  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 3), () {
      checkAuth();
    });
  }

  void checkAuth() {
    final token = storage.read("token");

    if (token != null && token.isNotEmpty) {
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.offAllNamed(Routes.ON_BOARDING);
    }
  }
}
