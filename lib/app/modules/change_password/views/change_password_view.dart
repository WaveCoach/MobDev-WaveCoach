import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mob_dev_wave_coach/app/core/values/app_colors.dart';
import 'package:mob_dev_wave_coach/app/modules/change_password/controllers/change_password_controller.dart';

class ChangePasswordView extends StatefulWidget {
  @override
  _ChangePasswordViewState createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final ChangePasswordController controller = Get.put(
    ChangePasswordController(),
  );

  // Obscure text flags for each password field
  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final ScrollController _scrollController = ScrollController();
  final FocusNode _currentPasswordFocus = FocusNode();
  final FocusNode _newPasswordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    _scrollController.dispose();
    _currentPasswordFocus.dispose();
    _newPasswordFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  void _scrollToFocusedField(FocusNode focusNode) {
    Future.delayed(Duration(milliseconds: 300), () {
      if (focusNode.hasFocus) {
        RenderObject? object = focusNode.context?.findRenderObject();
        if (object != null && object is RenderBox) {
          Rect rect = object.paintBounds;
          Offset offset = object.localToGlobal(Offset.zero);
          double targetOffset = offset.dy + rect.height - MediaQuery.of(context).size.height * 0.4;

          // Ensure offset is not negative
          targetOffset = targetOffset.clamp(0.0, _scrollController.position.maxScrollExtent);

          _scrollController.animateTo(
            targetOffset,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ubah Kata Sandi")),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // Menutup keyboard
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 60, 30, 20),
                child: Text(
                  "Atur Ulang Kata Sandi Anda!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: AppColors.deepOceanBlue,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    height: 1,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 60),
                child: Text(
                  "Example@gmail.com",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: AppColors.deepOceanBlue,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    height: 1.27,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              _buildPasswordField(
                "Current Password",
                currentPasswordController,
                _currentPasswordFocus,
                _obscureCurrentPassword,
                () {
                  setState(() {
                    _obscureCurrentPassword = !_obscureCurrentPassword;
                  });
                },
              ),
              _buildPasswordField(
                "New Password",
                newPasswordController,
                _newPasswordFocus,
                _obscureNewPassword,
                () {
                  setState(() {
                    _obscureNewPassword = !_obscureNewPassword;
                  });
                },
              ),
              _buildPasswordField(
                "Confirm Password",
                confirmPasswordController,
                _confirmPasswordFocus,
                _obscureConfirmPassword,
                () {
                  setState(() {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  });
                },
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: ElevatedButton(
                  onPressed: () {
                    controller.sendChangePassword(
                      currentPasswordController.text,
                      newPasswordController.text,
                      confirmPasswordController.text,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.deepOceanBlue,
                    minimumSize: Size(double.infinity, 64),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    "Submit",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
                GestureDetector(
                onTap: () {
                  Get.toNamed('/forget-pass');
                },
                child: Text(
                  "Lupa Kata Sandi?",
                  style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: AppColors.deepOceanBlue,
                  decoration: TextDecoration.underline,
                  ),
                ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField(
    String labelText,
    TextEditingController controller,
    FocusNode focusNode,
    bool obscureText,
    VoidCallback toggleObscureText,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
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
              color: AppColors.deepOceanBlue,
            ),
            child: Center(
              child: Icon(Icons.lock_outline, color: Colors.white, size: 28),
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
                        controller: controller,
                        focusNode: focusNode,
                        onTap: () => _scrollToFocusedField(focusNode),
                        obscureText: obscureText,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: AppColors.deepOceanBlue,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Password",
                          labelText: labelText,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: GestureDetector(
                        onTap: toggleObscureText,
                        child: Icon(
                          obscureText ? Icons.visibility_off : Icons.visibility,
                          color: AppColors.deepOceanBlue,
                          size: 28,
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
}
