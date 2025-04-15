import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/bukti_pengembalian_controller.dart';

class BuktiPengembalianView extends GetView<BuktiPengembalianController> {
  const BuktiPengembalianView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BuktiPengembalianView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'BuktiPengembalianView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
