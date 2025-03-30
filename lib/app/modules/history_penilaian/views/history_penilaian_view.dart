import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/history_penilaian_controller.dart';

class HistoryPenilaianView extends GetView<HistoryPenilaianController> {
  const HistoryPenilaianView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HistoryPenilaianView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'HistoryPenilaianView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
