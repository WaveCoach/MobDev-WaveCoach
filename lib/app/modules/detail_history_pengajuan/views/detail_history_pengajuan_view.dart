import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_history_pengajuan_controller.dart';

class DetailHistoryPengajuanView
    extends GetView<DetailHistoryPengajuanController> {
  const DetailHistoryPengajuanView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailHistoryPengajuanView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DetailHistoryPengajuanView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
