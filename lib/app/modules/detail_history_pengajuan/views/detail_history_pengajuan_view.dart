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
        title: const Text('Detail History Pengajuan'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // Cek jika data request tersedia
        if (controller.historyRequestResponse.value != null) {
          final data = controller.historyRequestResponse.value!;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text("ID: ${data.data.id}"),
              Text("Nama coach: ${data.data.coachName}"),
              Text("nama mastercoach: ${data.data.mastercoachName}"),
              Text("Tanggal pinjam: ${data.data.tanggalPinjam}"),
              Text("Tanggal kembali: ${data.data.tanggalKembali}"),
              Text("alasan pinjam: ${data.data.alasanPinjam}"),
              Text("status: ${data.data.status}"),

              // Tambahkan field lain sesuai kebutuhan
            ],
          );
        }

        // Cek jika data return tersedia
        if (controller.historyReturnResponse.value != null) {
          final data = controller.historyReturnResponse.value!;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text("ID: ${data.data.id}"),
              Text("Nama coach: ${data.data.coachName}"),
              Text("nama mastercoach: ${data.data.mastercoachName}"),
              Text("Tanggal pinjam: ${data.data.landingTanggalPinjam}"),
              Text("Tanggal kembali: ${data.data.landingTanggalKembali}"),
              Text("alasan pinjam: ${data.data.landingAlasanPinjam}"),
              Text("status: ${data.data.status}"),
              // Tambahkan field lain sesuai kebutuhan
            ],
          );
        }

        // Jika data tidak tersedia
        return const Center(child: Text("Data tidak ditemukan."));
      }),
    );
  }
}
