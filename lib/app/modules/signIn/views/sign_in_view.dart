import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mob_dev_wave_coach/app/core/values/app_colors.dart';
import '../controllers/sign_in_controller.dart';

class SignInView extends StatelessWidget {
  final SignInController controller = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    bool _obscureText = true;

    Widget header() {
      return Column(
        children: [
          Image.asset('assets/images/LatinWaveCoach.png', width: 250),

          Padding(
            padding: const EdgeInsets.fromLTRB(0, 60, 0, 20),
            child: Text(
              "Come on Board",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontWeight:
                    FontWeight.w500, // Medium (sesuai dengan "poppins_medium")
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(100, 0, 100, 60),
            child: Text(
              "Let's login to your account first!",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontWeight:
                    FontWeight.w500, // Medium (sesuai dengan "poppins_medium")
                fontSize: 20,
                color: AppColors.skyBlue,
              ),
            ),
          ),
        ],
      );
    }

    Widget emailInput() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
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
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  border: Border.all(color: AppColors.skyBlue, width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {});
                      },
                      controller: controller.emailController,
                      style: GoogleFonts.poppins(
                        fontWeight:
                            FontWeight
                                .w500, // Medium (sesuai dengan "poppins_medium")
                        fontSize: 14,
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Email",
                        hintStyle: GoogleFonts.poppins(
                          fontWeight:
                              FontWeight
                                  .w500, // Medium (sesuai dengan "poppins_medium")
                          fontSize: 14,
                          color: AppColors.mistyBlue,
                        ),
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

    Widget passwordInput() {
      return Padding(
        padding: const EdgeInsets.fromLTRB(40, 15, 40, 0),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                color: Colors.white,
              ),
              child: Center(
                child: Image.asset(
                  'assets/images/LoginPasswordIcon.png',
                  width: 28,
                  height: 28,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 64,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  border: Border.all(color: AppColors.pastelBlue, width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {});
                          },
                          controller: controller.passwordController,
                          obscureText: true,
                          style: GoogleFonts.poppins(
                            fontWeight:
                                FontWeight
                                    .w500, // Medium (sesuai dengan "poppins_medium")
                            fontSize: 14,
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Password",
                            hintStyle: GoogleFonts.poppins(
                fontWeight:
                    FontWeight.w500, // Medium (sesuai dengan "poppins_medium")
                fontSize: 14,
                color: AppColors.pastelBlue,
              ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          child: Image.asset(
                            _obscureText
                                ? 'assets/images/ShowPassword.png'
                                : 'assets/images/HidePassword.png',
                            width: 28,
                            height: 28,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.deepOceanBlue,
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  header(),

                  emailInput(),

                  passwordInput(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // rememberMe(),

                        // forgotPassword()
                      ],
                    ),
                  ),

                  // loginButton(),

                  // textHubungiAdmin(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
