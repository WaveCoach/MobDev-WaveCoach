import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_dev_wave_coach/app/core/values/app_colors.dart';
import '../controllers/forget_pass_controller.dart';

class ForgetPassView extends GetView<ForgetPassController> {
  const ForgetPassView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.deepOceanBlue,
      body: Center(
        child: Stack(
          children: [
            Positioned(
              left: 25,
              top: 80,
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Row(
                  children: const [
                    Icon(Icons.arrow_back, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      "Kembali",
                      style: TextStyle(
                        fontFamily: "poppins_semibold",
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/LatinWaveCoach.png',
                        width: 121,
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(30, 60, 30, 20),
                        child: Text(
                          "Forgot Password",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "poppins_bold",
                            fontSize: 45,
                            color: Colors.white,
                            height: 1,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(30, 0, 30, 60),
                        child: Text(
                          "Masukkan email anda untuk mengubah kata sandi",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "poppins_medium",
                            fontSize: 20,
                            color: AppColors.mistyBlue,
                            height: 1.27,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          children: [
                            Container(
                              width: 64,
                              height: 64,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                ),
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Image.asset(
                                  'assets/images/LoginEmailIcon.png',
                                  width: 28,
                                  height: 28,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 64,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  ),
                                  border: Border.all(
                                    color: AppColors.mistyBlue,
                                    width: 1,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: TextFormField(
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    style: const TextStyle(
                                      fontFamily: "poppins_medium",
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Email",
                                      hintStyle: TextStyle(
                                        fontFamily: "poppins_medium",
                                        fontSize: 14,
                                        color: AppColors.mistyBlue,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 70, 40, 0),
                        child: Obx(
                          () => GestureDetector(
                            onTap:
                                controller.isLoading.value
                                    ? null
                                    : () {
                                      String email =
                                          emailController.text.trim();
                                      if (email.isEmail) {
                                        controller.sendResetPassword(email);
                                      } else {
                                        Get.snackbar(
                                          "Error",
                                          "Email tidak valid",
                                        );
                                      }
                                    },
                            child: Container(
                              height: 64,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color:
                                    controller.isLoading.value
                                        ? Colors.grey
                                        : Colors.white,
                              ),
                              child: Center(
                                child:
                                    controller.isLoading.value
                                        ? const CircularProgressIndicator()
                                        : const Text(
                                          "Submit",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: "poppins_regular",
                                            fontSize: 18,
                                            color: AppColors.deepOceanBlue,
                                          ),
                                        ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
