import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mob_dev_wave_coach/app/core/values/app_colors.dart';
import '../controllers/detail_inventaris_controller.dart';

class DetailInventarisView extends StatefulWidget {
  @override
  _DetailInventarisViewState createState() => _DetailInventarisViewState();
}

class _DetailInventarisViewState extends State<DetailInventarisView> {
  final DetailInventarisController controller =
      Get.find<DetailInventarisController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
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
                "Nama\nBarang",
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
          Expanded(
            child: Obx(() {
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
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 5,
                      ),
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: ListTile(
                          tileColor:
                              Colors
                                  .white, // Menambahkan warna putih pada ListTile
                          subtitle: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Nama Master Coach",
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  item.mastercoachName,
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Tanggal Pinjam",
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  item.tanggalPinjam,
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Tanggal Kembali",
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  item.tanggalKembali,
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Jumlah",
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "${item.qtyOut}",
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Kondisi",
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  item.status,
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 20),
                                SizedBox(
                                  width:
                                      double
                                          .infinity, // Memenuhi ruang antara kiri dan kanan
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (item.status == "borrowed") {
                                        Get.toNamed('/form-ajuan-pengembalian');
                                      } else if (item.status == "returned") {
                                        Get.toNamed('/bukti-pengembalian');
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.black,
                                      backgroundColor:
                                          item.status == "borrowed"
                                              ? AppColors.goldenAmber
                                              : Colors
                                                  .green, // Change color based on status
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Text(
                                      item.status == "borrowed"
                                          ? "Ajukan Pengembalian"
                                          : "Bukti Pengembalian", // Change text based on status
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
