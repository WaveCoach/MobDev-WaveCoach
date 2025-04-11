import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/detail_inventaris_controller.dart';

class DetailInventarisView extends GetView<DetailInventarisController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Inventaris')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.borrowingList.isEmpty) {
          return const Center(child: Text("Tidak ada data peminjaman."));
        }

        return RefreshIndicator(
          onRefresh: controller.refreshBorrowingList,
          child: ListView.builder(
            itemCount: controller.borrowingList.length,
            itemBuilder: (context, index) {
              final item = controller.borrowingList[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(item.inventoryName ?? "-"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Tanggal Pinjam: ${item.tanggalPinjam}"),
                      Text("Tanggal Kembali: ${item.tanggalKembali}"),
                      Text("Status: ${item.status}"),
                      Text("Qty Keluar: ${item.qtyOut}"),
                      Text("Coach: ${item.coachName}"),
                      Text("Mastercoach: ${item.mastercoachName}"),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
