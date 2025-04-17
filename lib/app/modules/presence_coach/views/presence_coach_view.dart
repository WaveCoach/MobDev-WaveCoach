import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      body: Obx(
        () => Stack(
          children: [
            // Header
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 230,
                decoration: BoxDecoration(
                  color: AppColors.deepOceanBlue,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: const Text(
                          "Absensi Coach",
                          style: TextStyle(
                            fontFamily: "poppins_semibold",
                            fontSize: 32,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 15,
                      top: 70,
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          const Text(
                            "Kembali",
                            style: TextStyle(
                              fontFamily: "poppins_semibold",
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Content
            Positioned(
              top: 230,
              left: 0,
              right: 0,
              bottom: 0,
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
                      child: const Text(
                        "Presensi Kehadiran",
                        style: TextStyle(
                          fontFamily: "poppins_semibold",
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
                        child: const Text(
                          "Ambil Gambar",
                          style: TextStyle(
                            fontFamily: "poppins_semibold",
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
            onPressed:
                controller.isSubmitting.value
                    ? null
                    : () {
                      final scheduleId = Get.arguments['scheduleId'];

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
                      } else {
                        Get.snackbar(
                          "Peringatan",
                          "Lengkapi presensi terlebih dahulu.",
                        );
                      }
                    },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  controller.isSubmitting.value
                      ? Colors.grey
                      : const Color(0xFF264C6B),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
            child:
                controller.isSubmitting.value
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                      "Upload",
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
