import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/inventaris_controller.dart';

class InventarisView extends GetView<InventarisController> {
  const InventarisView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InventarisView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'InventarisView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
