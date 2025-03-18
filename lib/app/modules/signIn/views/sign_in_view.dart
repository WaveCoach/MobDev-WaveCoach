import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/sign_in_controller.dart';

class SignInView extends StatelessWidget {
  final SignInController controller = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign In")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller.emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: controller.passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: "Password"),
            ),
            SizedBox(height: 20),
            Obx(
              () =>
                  controller.isLoading.value
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                        onPressed: () => controller.signIn(),
                        child: Text("Sign In"),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
