import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:mob_dev_wave_coach/app/core/values/app_colors.dart';
import 'package:mob_dev_wave_coach/app/modules/camera_location/views/camera_location_view.dart';
import 'package:mob_dev_wave_coach/app/modules/presence_coach/controllers/presence_coach_controller.dart';

class PresenceCoachView extends StatefulWidget {
  const PresenceCoachView({super.key});

  @override
  State<PresenceCoachView> createState() => _PresenceCoachState();
}

class _PresenceCoachState extends State<PresenceCoachView> {
  final PresenceCoachController controller = Get.put(PresenceCoachController());
  Color hadirButtonColor = Colors.white;
  Color tidakHadirButtonColor = Colors.white;
  // bool showBuktiKehadiranButton = false;
  bool showAlasanTidakHadir = false;
  XFile? proof;
  final TextEditingController alasanController = TextEditingController();

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
      body: Obx(
        () => Column(
          children: [
            // Header
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
                "Absensi\nCoach",
                textAlign: TextAlign.center, // Set text alignment to center
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                  letterSpacing: -0.5,
                ),
              ),
            ),
          ),
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Presensi Kehadiran
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: AppColors.deepOceanBlue,
                      ),
                      child: Text(
                        "Presensi Kehadiran",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 70,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  hadirButtonColor = Colors.green;
                                  tidakHadirButtonColor = Colors.white;
                                  controller.showBuktiKehadiranButton.value =
                                      true;
                                  showAlasanTidakHadir = false;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: hadirButtonColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                "Hadir",
                                style: TextStyle(
                                  fontFamily: "poppins_semibold",
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: SizedBox(
                            height: 70,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  hadirButtonColor = Colors.white;
                                  tidakHadirButtonColor = Colors.red;
                                  controller.showBuktiKehadiranButton.value =
                                      false;
                                  showAlasanTidakHadir = true;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: tidakHadirButtonColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                "Tidak hadir",
                                style: TextStyle(
                                  fontFamily: "poppins_semibold",
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (controller.showBuktiKehadiranButton.value) ...[
                      const SizedBox(height: 50),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: AppColors.deepOceanBlue,
                        ),
                        child: Text(
                          "Ambil Gambar",
                          style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: SizedBox(
                          height: 70,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              controller.capturedImagePath.value =
                                  await Get.to(CameraLocationView()) ?? '';

                              // debugPrint(
                              //   "📸 Captured Image Path: ${controller.capturedImagePath.value}",
                              // );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.goldenAmber,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              "Bukti Kehadiran",
                              style: TextStyle(
                                fontFamily: "poppins_semibold",
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (proof != null ||
                          controller.capturedImagePath.value != '')
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // if (controller.capturedImagePath.value != '')
                            //   Center(
                            //     child: Image.file(
                            //       File(controller.capturedImagePath.value),
                            //       width: 200,
                            //       height: 200,
                            //       fit: BoxFit.cover,
                            //     ),
                            //   ),
                            const SizedBox(height: 20),
                            Center(
                              child: SizedBox(
                                height: 70,
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder:
                                          (context) => AlertDialog(
                                            content:
                                                controller
                                                            .capturedImagePath
                                                            .value !=
                                                        ''
                                                    ? Image.file(
                                                      File(
                                                        controller
                                                            .capturedImagePath
                                                            .value,
                                                      ),
                                                      fit: BoxFit.cover,
                                                    )
                                                    : const Text(
                                                      "Gambar tidak tersedia",
                                                    ),
                                          ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.deepOceanBlue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text(
                                    "Lihat Preview",
                                    style: TextStyle(
                                      fontFamily: "poppins_semibold",
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                    if (showAlasanTidakHadir) ...[
                      const SizedBox(height: 50),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: AppColors.deepOceanBlue,
                        ),
                        child: const Text(
                          "Alasan Tidak Hadir",
                          style: TextStyle(
                            fontFamily: "poppins_semibold",
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withAlpha(128),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: alasanController,
                          maxLines: 5,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'Masukkan alasan tidak hadir',
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Obx(
          () => ElevatedButton(
            onPressed: controller.isSubmitting.value
                ? null
                : () {
                    final scheduleId = Get.arguments['scheduleId'];

                    if (controller.showBuktiKehadiranButton.value || showAlasanTidakHadir) {
                      // Tampilkan dialog konfirmasi
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            title: Text(
                              "Konfirmasi",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                            content: Text(
                              "Apakah Anda yakin ingin mengirim presensi?",
                              style: GoogleFonts.poppins(fontSize: 16),
                            ),
                            actions: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: 50,
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.grey[300],
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop(); // Tutup dialog
                                        },
                                        child: Text(
                                          "Batal",
                                          style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: SizedBox(
                                      height: 50,
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                          backgroundColor: AppColors.deepOceanBlue,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop(); // Tutup dialog
                                          if (controller.showBuktiKehadiranButton.value) {
                                            controller.submitPresence(
                                              attendanceStatus: "Hadir",
                                              scheduleId: scheduleId,
                                            );
                                          } else if (showAlasanTidakHadir) {
                                            controller.submitPresence(
                                              attendanceStatus: "Tidak Hadir",
                                              scheduleId: scheduleId,
                                              remarks: alasanController.text,
                                            );
                                          }
                                        },
                                        child: Text(
                                          "Ya",
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      Get.snackbar(
                        "Peringatan",
                        "Lengkapi presensi terlebih dahulu.",
                      );
                    }
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: controller.isSubmitting.value
                  ? Colors.grey
                  : const Color(0xFF264C6B),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
            child: controller.isSubmitting.value
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text(
                  "Submit",
                  style: TextStyle(
                    fontFamily: "poppins_semibold",
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
