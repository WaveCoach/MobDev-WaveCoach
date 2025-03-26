import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mob_dev_wave_coach/app/core/values/app_colors.dart';
import 'package:mob_dev_wave_coach/app/modules/onBoarding/controllers/on_boarding_controller.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final OnBoardingController controller = Get.put(OnBoardingController());

    return Scaffold(
      body: Column(
        children: [
          // **Indicator**
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  controller.onboardingData.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: controller.currentPage.value == index ? 50 : 15,
                    height: 15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1000),
                      color:
                          controller.currentPage.value == index
                              ? AppColors.deepOceanBlue
                              : AppColors.mistyBlue,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // **PageView**
          Expanded(
            child: PageView.builder(
              controller: controller.pageController,
              onPageChanged: controller.updatePage,
              itemCount: controller.onboardingData.length,
              itemBuilder: (_, i) {
                final data = controller.onboardingData[i];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(data["image"]!, width: 400, height: 300),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 80, 20, 0),
                      child: Column(
                        children: [
                          Text(
                            data["title"]!,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 32,
                              color: AppColors.deepOceanBlue,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 46),
                            child: Text(
                              data["description"]!,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: AppColors.deepOceanBlue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          // **Button**
          GestureDetector(
            onTap: controller.nextPage,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 70),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1000),
                  color: AppColors.deepOceanBlue,
                ),
                child: Obx(
                  () => Text(
                    controller.currentPage.value ==
                            controller.onboardingData.length - 1
                        ? "Login"
                        : "Next",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
