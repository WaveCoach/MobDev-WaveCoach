import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/presence_student_controller.dart';

class PresenceStudentView extends GetView<PresenceStudentController> {
  const PresenceStudentView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PresenceStudentView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PresenceStudentView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
