import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mob_dev_wave_coach/app/core/values/app_colors.dart';
import 'package:mob_dev_wave_coach/app/modules/history_penilaian_detail/controllers/history_penilaian_detail_controller.dart';

class HistoryPenilaianDetailView extends StatefulWidget {
  const HistoryPenilaianDetailView({Key? key}) : super(key: key);

  @override
  State<HistoryPenilaianDetailView> createState() =>
      _HistoryPenilaianDetailViewState();
}

class _HistoryPenilaianDetailViewState
    extends State<HistoryPenilaianDetailView> {
  late HistoryPenilaianDetailController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<HistoryPenilaianDetailController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0, // Adjust spacing between back icon and title
        title: Text(
          "Kembali",
          style: GoogleFonts.poppins(
            color: AppColors.deepOceanBlue,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: AppColors.skyBlue,
        iconTheme: const IconThemeData(color: AppColors.deepOceanBlue),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark, // Set icons to dark (gray)
          statusBarColor:
              Colors.transparent, // Optional: Make status bar transparent
        ),
      ),
      backgroundColor: AppColors.skyBlue,
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
              //Nama Siswa
              Text(
                data.data.studentName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              //Nama Paket
              Text(
                data.data.packageName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              //Gaya Renang
              Text(
                data.data.categoryName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              //Tanggal Penilaian
              Text(
                data.data.date,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
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
