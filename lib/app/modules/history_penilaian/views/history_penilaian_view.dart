import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_dev_wave_coach/app/modules/history_penilaian/controllers/history_penilaian_controller.dart';

class HistoryPenilaianView extends GetView<HistoryPenilaianController> {
  const HistoryPenilaianView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Penilaian')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: controller.searchController,
              decoration: InputDecoration(
                hintText: 'Cari...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    controller.searchController.clear();
                    controller.fetchHistoryPenilaian();
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onSubmitted: (value) {
                controller.fetchHistoryPenilaian(query: value);
              },
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.historyPenilaianList.isEmpty) {
                return const Center(child: Text('Belum ada data.'));
              }

              return ListView.builder(
                itemCount: controller.historyPenilaianList.length,
                itemBuilder: (context, index) {
                  final item = controller.historyPenilaianList[index];

                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: ListTile(
                      title: Text(item.studentName),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Tanggal: ${item.date}'),
                          Text('Assessor: ${item.assessorName}'),
                          Text('Paket: ${item.packageName}'),
                          Text('Kategori: ${item.categoryName}'),
                        ],
                      ),
                      onTap: () {
                        Get.toNamed(
                          '/history-penilaian-detail',
                          arguments: item.id,
                        );
                      },
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
