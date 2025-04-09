import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_dev_wave_coach/app/modules/history_penilaian_detail/controllers/history_penilaian_detail_controller.dart';

class HistoryPenilaianDetailView extends StatelessWidget {
  const HistoryPenilaianDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HistoryPenilaianDetailController>();

    return Scaffold(
      appBar: AppBar(title: const Text('History Penilaian Detail')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = controller.historyDetailResponse.value;

        if (data == null) {
          return const Center(child: Text('Data tidak ditemukan'));
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              TextField(
                controller: TextEditingController(text: data.data.date),
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Tanggal',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: TextEditingController(text: data.data.studentName),
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Input 2',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Input 3',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Input 4',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Input 5',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
