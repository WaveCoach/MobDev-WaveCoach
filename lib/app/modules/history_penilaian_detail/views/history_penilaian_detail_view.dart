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

        return SingleChildScrollView(
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
                controller: TextEditingController(
                  text:
                      '${data.data.scheduleDate} | ${data.data.scheduleStartTime} - ${data.data.scheduleEndTime}',
                ),
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Jadwal',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: TextEditingController(text: data.data.packageName),
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Nama Paket',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: TextEditingController(text: data.data.studentName),
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Nama Siswa',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: TextEditingController(text: data.data.categoryName),
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Nama Gaya',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),

              const SizedBox(height: 8),
              ...data.data.details.map((aspect) {
                return ExpansionTile(
                  title: Text(
                    aspect.aspectName ?? 'Aspek',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle:
                      aspect.aspectDesc != null
                          ? Text(aspect.aspectDesc!)
                          : null,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: TextEditingController(
                              text: aspect.score.toString(),
                            ),
                            readOnly: true,
                            decoration: const InputDecoration(
                              labelText: 'Nilai',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: TextEditingController(
                              text: aspect.remarks,
                            ),
                            readOnly: true,
                            decoration: const InputDecoration(
                              labelText: 'Catatan',
                              border: OutlineInputBorder(),
                            ),
                            maxLines: 3,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ],
          ),
        );
      }),
    );
  }
}
