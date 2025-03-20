import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/new_pass_controller.dart';

class NewPassView extends GetView<NewPassController> {
  const NewPassView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NewPassView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'NewPassView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
