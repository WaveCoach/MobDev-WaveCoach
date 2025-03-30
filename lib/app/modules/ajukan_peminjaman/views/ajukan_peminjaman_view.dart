import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/ajukan_peminjaman_controller.dart';

class AjukanPeminjamanView extends GetView<AjukanPeminjamanController> {
  const AjukanPeminjamanView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AjukanPeminjamanView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AjukanPeminjamanView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
