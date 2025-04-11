import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mob_dev_wave_coach/app/core/values/app_colors.dart';
import 'package:mob_dev_wave_coach/app/modules/history_penilaian_detail/controllers/history_penilaian_detail_controller.dart';
import 'package:intl/date_symbol_data_local.dart'; // Tambahkan ini

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

    // Inisialisasi locale untuk DateFormat
    initializeDateFormatting('id_ID', null);
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

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bagian statis (tidak ikut scroll)
              Text(
                data.data.studentName,
                style: GoogleFonts.poppins(
                  color: Color(0xFF4C4C4C),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  height: 1,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                data.data.packageName,
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  height: 1,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                data.data.categoryName,
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  height: 1,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                DateFormat(
                  'd MMMM yyyy',
                  'id_ID',
                ).format(DateTime.parse(data.data.date)),
                style: GoogleFonts.poppins(
                  color: AppColors.deepOceanBlue,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              Divider(color: Colors.black.withOpacity(0.2), thickness: 1),
              // Bagian scrollable
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            "Nama Siswa",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: TextFormField(
                              controller: TextEditingController(
                                text:
                                    data.data.studentName,
                              ),
                              style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                              decoration: const InputDecoration(
                                labelText: "Nama Siswa",
                                labelStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                              ),
                              readOnly: true,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            "Jadwal Latihan",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: TextFormField(
                              controller: TextEditingController(
                                text:
                                    '${DateFormat('dd-MM-yyyy').format(DateTime.parse(data.data.scheduleDate))} | ${DateFormat('HH:mm').format(DateFormat('HH:mm:ss').parse(data.data.scheduleStartTime))} - ${DateFormat('HH:mm').format(DateFormat('HH:mm:ss').parse(data.data.scheduleEndTime))}',
                              ),
                              style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                              decoration: const InputDecoration(
                                labelText: "Jadwal",
                                labelStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                              ),
                              readOnly: true,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            "Gaya Renang",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: TextFormField(
                              controller: TextEditingController(
                                text:
                                    data.data.categoryName,
                              ),
                              style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                              decoration: const InputDecoration(
                                labelText: "Gaya Renang",
                                labelStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                              ),
                              readOnly: true,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ...data.data.details.map((aspect) {
                          return Container(
                            margin: const EdgeInsets.only(
                              bottom: 12,
                            ), // Add spacing between items
                            decoration: BoxDecoration(
                              color: AppColors.deepOceanBlue,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ExpansionTile(
                              title: Text(
                                aspect.aspectName ?? 'Aspek',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                              subtitle: Text(
                                aspect.aspectDesc ?? 'Deskripsi tidak tersedia',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                              iconColor: Colors.white,
                              collapsedIconColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.grey, width: 0),
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Nilai",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          right: 280,
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            color: Colors.white,
                                            border: Border.all(
                                              color: Colors.black.withOpacity(
                                                0.2,
                                              ),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                            ),
                                            child: TextField(
                                              controller: TextEditingController(
                                                text: aspect.score.toString(),
                                              ),
                                              readOnly: true,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 8),

                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Komentar",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          color: Colors.white,
                                          border: Border.all(
                                            color: Colors.black.withOpacity(
                                              0.2,
                                            ),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                          ),
                                          child: TextField(
                                            controller: TextEditingController(
                                              text: aspect.remarks,
                                            ),
                                            readOnly: true,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                            maxLines: 3,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
