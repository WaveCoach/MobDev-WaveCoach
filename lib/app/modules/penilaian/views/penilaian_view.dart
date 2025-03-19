import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/penilaian_controller.dart';

class PenilaianView extends GetView<PenilaianController> {
  const PenilaianView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PenilaianView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PenilaianView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
