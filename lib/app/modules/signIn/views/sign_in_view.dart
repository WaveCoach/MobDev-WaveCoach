import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mob_dev_wave_coach/app/core/values/app_colors.dart';
import '../controllers/sign_in_controller.dart';

class SignInView extends StatefulWidget {
  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final SignInController controller = Get.put(SignInController());
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Column(
        children: [
          Image.asset('assets/images/LatinWaveCoach.png', width: 250),

          Padding(
            padding: const EdgeInsets.fromLTRB(0, 60, 0, 10),
            child: Text(
              "Come on Board",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontWeight:
                    FontWeight.w500, // Medium (sesuai dengan "poppins_medium")
                fontSize: 30,
                color: Colors.white,
                letterSpacing: -0.5,
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
                color: AppColors.mistyBlue,
                letterSpacing: -0.5,
                height: 1.2,
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
                  border: Border.all(color: AppColors.mistyBlue, width: 1),
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
                  border: Border.all(color: AppColors.mistyBlue, width: 1),
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
                          obscureText: _obscureText,
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
                                  FontWeight
                                      .w500, // Medium (sesuai dengan "poppins_medium")
                              fontSize: 14,
                              color: AppColors.mistyBlue,
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

    Widget rememberMe() {
      return Row(
        children: [
          Checkbox(
            value: true,
            onChanged: (bool? value) {
              // Handle checkbox state change
            },
            checkColor: AppColors.deepOceanBlue,
            activeColor: Colors.white,
            side: BorderSide(color: Colors.white),
            fillColor: WidgetStateProperty.resolveWith<Color>((
              Set<WidgetState> states,
            ) {
              if (states.contains(WidgetState.selected)) {
                return Colors.white;
              }
              return Colors.transparent;
            }),
          ),
          Text(
            "Remember me",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: "poppins_medium",
            ),
          ),
        ],
      );
    }

    Widget forgotPassword() {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/forget-pass');
        },
        child: Text(
          "Forgot Password?",
          style: GoogleFonts.poppins(
            fontWeight:
                FontWeight.w500, // Medium (sesuai dengan "poppins_medium")
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      );
    }

    Widget loginButton() {
      return Padding(
        padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
        child: Obx(
          () =>
              controller.isLoading.value
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                    onPressed: () {
                      if (controller.emailController.text != "" &&
                          controller.passwordController.text != "") {
                        controller.signIn();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          controller.emailController.text != "" &&
                                  controller.passwordController.text != ""
                              ? Colors.white
                              : Colors.white.withValues(alpha: 0.3),
                      minimumSize: Size(double.infinity, 64),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      "Login",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        color: AppColors.deepOceanBlue,
                      ),
                    ),
                  ),
        ),
      );
    }

    Widget textHubungiAdmin() {
      return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Mengalami Kendala?",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: Colors.white,
                letterSpacing: -0.5,
              ),
            ),
            SizedBox(width: 5),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/contact-admin');
              },
              child: Text(
                "Hubungi Admin",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Colors.white,
                  letterSpacing: -0.5,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                      children: [rememberMe(), forgotPassword()],
                    ),
                  ),

                  loginButton(),

                  textHubungiAdmin(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
