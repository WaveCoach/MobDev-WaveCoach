import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/ajukan_pengembalian_controller.dart';

class AjukanPengembalianView extends GetView<AjukanPengembalianController> {
  const AjukanPengembalianView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AjukanPengembalianView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AjukanPengembalianView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
