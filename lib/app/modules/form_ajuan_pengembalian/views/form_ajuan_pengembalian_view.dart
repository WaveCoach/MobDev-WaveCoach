import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/form_ajuan_pengembalian_controller.dart';

class FormAjuanPengembalianView
    extends GetView<FormAjuanPengembalianController> {
  const FormAjuanPengembalianView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FormAjuanPengembalianView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'FormAjuanPengembalianView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
