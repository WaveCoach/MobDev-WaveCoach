import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_dev_wave_coach/app/modules/change_password/controllers/change_password_controller.dart';

class ChangePasswordView extends StatefulWidget {
  @override
  _ChangePasswordViewState createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final ChangePasswordController controller = Get.put(
    ChangePasswordController(),
  );
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Change Password")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: currentPasswordController,
              decoration: InputDecoration(labelText: "Current Password"),
              obscureText: true,
            ),
            SizedBox(height: 10),
            TextField(
              controller: newPasswordController,
              decoration: InputDecoration(labelText: "New Password"),
              obscureText: true,
            ),
            SizedBox(height: 10),
            TextField(
              controller: confirmPasswordController,
              decoration: InputDecoration(labelText: "Confirm Password"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.sendChangePassword(
                  currentPasswordController.text,
                  newPasswordController.text,
                  confirmPasswordController.text,
                );
              },
              child: Text("Change Password"),
            ),
          ],
        ),
      ),
    );
  }
}
