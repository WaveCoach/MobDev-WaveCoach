import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mob_dev_wave_coach/app/core/values/app_colors.dart';
import 'package:mob_dev_wave_coach/app/modules/history_penilaian/controllers/history_penilaian_controller.dart';

class HistoryPenilaianView extends StatefulWidget {
  const HistoryPenilaianView({super.key});

  @override
  _HistoryPenilaianViewState createState() => _HistoryPenilaianViewState();
}

class _HistoryPenilaianViewState extends State<HistoryPenilaianView> {
  final HistoryPenilaianController controller =
      Get.find<HistoryPenilaianController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0, // Adjust spacing between back icon and title
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.offNamed('/home', arguments: 2);
          },
        ),
        title: Text(
          "Kembali",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: AppColors.deepOceanBlue,
        iconTheme: const IconThemeData(color: Colors.white),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark, // Set icons to dark (gray)
          statusBarColor:
              Colors.transparent, // Optional: Make status bar transparent
        ),
      ),
      backgroundColor: AppColors.skyBlue,
      body: Column(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.deepOceanBlue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Center(
              child: Text(
                "History\nPenilaian",
                textAlign: TextAlign.center, // Set text alignment to center
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  height: 1,
                  letterSpacing: -0.5,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 50,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.search, color: Colors.black54),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: controller.searchController,
                      decoration: InputDecoration(
                        hintText: "Search by Keywords",
                        border: InputBorder.none,
                        hintStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Colors.black54,
                          letterSpacing: -0.5,
                        ),
                      ),
                      onChanged: (value) {
                        controller.fetchHistoryPenilaian(query: value);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                // Panggil fungsi untuk memuat ulang data
                await controller.fetchHistoryPenilaian();
              },
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
                      color: AppColors.lightBlue,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: ListTile(
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.goldenAmber,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    child: Text(
                                      item.date ?? 'Unknown Date',
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  DateFormat('HH:mm').format(
                                    item.createdAt ?? DateTime.now(),
                                  ), // Extract time from createdAt
                                  style: GoogleFonts.poppins(
                                    color: AppColors.midnightNavy,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                //Paket Renang
                                Text(
                                  item.packageName ?? '-',
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Container(
                                  width: 1,
                                  height: 16,
                                  color: Colors.black,
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                ),
                                //Kategori Gaya
                                Text(
                                  item.categoryName ?? '-',
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            //Nama Siswa
                            Text(
                              item.studentName ?? '-',
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),

                            Text(
                              item.status ??
                                  '-', // Jika item.status null, tampilkan '-'
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),

                            Text(
                              (item.averageScore?.toString() ??
                                  '-'), // Mengonversi averageScore menjadi String atau '-'
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
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
          ),
        ],
      ),
    );
  }
}
