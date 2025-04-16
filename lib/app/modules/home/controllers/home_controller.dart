import 'package:get/get.dart';

class HomeController extends GetxController {
  var currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // Ambil argumen jika ada, untuk mengatur indeks awal
    currentIndex.value = Get.arguments ?? 0;
  }
}