import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/form_penilaian_controller.dart';

class FormPenilaianView extends GetView<FormPenilaianController> {
  const FormPenilaianView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FormPenilaianView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'FormPenilaianView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
