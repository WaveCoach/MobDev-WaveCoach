import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  // Data onboarding
  final List<Map<String, String>> onboardingData = [
    {
      "title": "Selamat Datang!",
      "description": "Lorem ipsum dolor sit amet consecte...",
      "image": "assets/images/onboarding1.png",
    },
    {
      "title": "Bangun Atlet Hebat",
      "description": "Lorem ipsum dolor sit amet consecte...",
      "image": "assets/images/onboarding2.png",
    },
    {
      "title": "Mentor Inspiratif",
      "description": "Lorem ipsum dolor sit amet consecte...",
      "image": "assets/images/onboarding3.png",
    },
  ];

  // Page controller untuk mengontrol PageView
  final PageController pageController = PageController();

  // Halaman saat ini
  var currentPage = 0.obs;

  // Update current page saat berpindah halaman
  void updatePage(int index) {
    currentPage.value = index;
  }

  // Fungsi untuk pindah ke halaman berikutnya atau navigasi ke login
  void nextPage() {
    if (currentPage.value < onboardingData.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigasi ke halaman login (Gantilah dengan route login yang sesuai)
      Get.offNamed("/sign-in");
    }
  }

  @override
  void onClose() {
    pageController.dispose(); // Pastikan controller dibersihkan
    super.onClose();
  }
}
