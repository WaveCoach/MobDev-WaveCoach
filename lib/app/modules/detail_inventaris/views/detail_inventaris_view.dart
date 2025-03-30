import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_inventaris_controller.dart';

class DetailInventarisView extends GetView<DetailInventarisController> {
  const DetailInventarisView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailInventarisView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DetailInventarisView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
