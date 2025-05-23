import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mob_dev_wave_coach/app/core/values/app_colors.dart';
import '../controllers/schedule_detail_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class ScheduleDetailView extends StatefulWidget {
  const ScheduleDetailView({super.key});

  @override
  State<ScheduleDetailView> createState() => _ScheduleDetailViewState();
}

class _ScheduleDetailViewState extends State<ScheduleDetailView> {
  final ScheduleDetailController controller = Get.put(
    ScheduleDetailController(),
  );

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.scheduleResponse.value == null) {
          return Center(child: Text("Data tidak tersedia"));
        }

        String dateString =
            controller.scheduleResponse.value?.schedule?.date ?? "";

        List<String> dateParts = dateString.split("-");

        String day = dateParts[2];

        Map<String, String> monthMap = {
          "01": "Januari",
          "02": "Februari",
          "03": "Maret",
          "04": "April",
          "05": "Mei",
          "06": "Juni",
          "07": "Juli",
          "08": "Agustus",
          "09": "September",
          "10": "Oktober",
          "11": "November",
          "12": "Desember",
        };

        String monthYear =
            "${monthMap[dateParts[1]]} ${dateParts[0]}"; // "Mei 2025"

        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.deepOceanBlue,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                controller.scheduleResponse.value?.schedule?.packageName ?? "",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  height: 1,
                ),
              ),
              SizedBox(
                child: Obx(() {
                  if (controller.scheduleResponse.value?.schedule?.status ==
                      "rescheduled") {
                    return AnimatedTextKit(
                      animatedTexts: [
                        ColorizeAnimatedText(
                          day,
                          textStyle: GoogleFonts.poppins(
                            fontSize: 150,
                            fontWeight: FontWeight.w700,
                            height: 1,
                          ),
                          colors: [
                            Colors.white,
                            Colors.white,
                            AppColors.deepOceanBlue,
                            Colors.white,
                            Colors.white,
                          ],
                          speed: Duration(milliseconds: 1500), // Durasi animasi
                        ),
                      ],
                      isRepeatingAnimation: true,
                      repeatForever: true,
                      pause: Duration(milliseconds: 2000), // Jeda antar animasi
                    );
                  } else {
                    return Text(
                      day,
                      style: GoogleFonts.poppins(
                        fontSize: 150,
                        fontWeight: FontWeight.w700,
                        height: 1,
                        color: Colors.white,
                      ),
                    );
                  }
                }),
              ),
              SizedBox(
                child: Obx(() {
                  if (controller.scheduleResponse.value?.schedule?.status ==
                      "rescheduled") {
                    return AnimatedTextKit(
                      animatedTexts: [
                        ColorizeAnimatedText(
                          monthYear,
                          textStyle: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                            height: 1,
                          ),
                          colors: [
                            Colors.white,
                            Colors.white,
                            AppColors.deepOceanBlue,
                            Colors.white,
                            Colors.white,
                          ],
                          speed: Duration(
                            milliseconds: 480,
                          ), // Durasi animasi sama
                        ),
                      ],
                      isRepeatingAnimation: true,
                      repeatForever: true,
                      pause: Duration(
                        milliseconds: 150,
                      ), // Jeda antar animasi sama
                    );
                  } else {
                    return Text(
                      monthYear,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        height: 1,
                      ),
                    );
                  }
                }),
              ),
              SizedBox(height: 20),
              Obx(() {
                final allStudentsMarked = controller.scheduleResponse.value?.students?.every(
                      (student) => student.attendanceStatus != null,
                    ) ?? false;

                final coachAttendanceStatus = controller.scheduleResponse.value?.coach?.attendanceStatus;

                if (controller.scheduleResponse.value?.schedule?.hasRescheduleRequest == false) {
                  if (allStudentsMarked) {
                    // Jika semua siswa telah melakukan absensi
                    return Text(
                      'Jadwal telah berlangsung',
                      style: GoogleFonts.poppins(
                        color: AppColors.lightGreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    );
                  } else {
                    // Jika absensi siswa belum selesai
                    return Opacity(
                      opacity: coachAttendanceStatus == "Tidak Hadir" ? 0.5 : 1.0, // Opasitas rendah jika coach "Tidak Hadir"
                      child: ElevatedButton.icon(
                        onPressed: coachAttendanceStatus == "Tidak Hadir"
                            ? null // Disable button if coach is "Tidak Hadir"
                            : () {
                                Get.toNamed(
                                  '/reschedule',
                                  arguments: {
                                    'scheduleId': controller.scheduleResponse.value?.schedule?.id,
                                  },
                                );
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: coachAttendanceStatus == "Tidak Hadir"
                              ? Colors.grey // Disabled button color
                              : Colors.orange,
                          padding: EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 25,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        icon: Icon(Icons.edit, color: Colors.white, size: 22),
                        label: Text(
                          'Pengajuan Reschedule',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    );
                  }
                } else {
                  return SizedBox.shrink(); // Tidak menampilkan apapun jika sudah ada permintaan reschedule
                }
              }),
            ],
          ),
        );
      });
    }

    Widget location() {
      return Obx(() {
        final schedule = controller.scheduleResponse.value?.schedule;
        final location = controller.scheduleResponse.value?.location;
        return Container(
          padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  // margin: EdgeInsets.only(right: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.access_time_filled,
                              size: 20,
                              color: AppColors.deepOceanBlue,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Pelaksanaan',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: AppColors.deepOceanBlue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.lightBlue.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          child: Text(
                            '${schedule?.startTime?.substring(0, 5)} - ${schedule?.endTime?.substring(0, 5)} WIB',
                            style: GoogleFonts.poppins(
                              color: AppColors.deepOceanBlue,
                              fontSize: 14,
                              fontWeight: FontWeightStyles.medium,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    final urlMaps = location?.maps ?? '';

                    // Cek apakah URL kosong
                    if (urlMaps.isEmpty) {
                      print("🚨 URL Maps kosong!");
                      return;
                    }

                    try {
                      final uri = Uri.tryParse(urlMaps);

                      // Cek apakah URI valid
                      if (uri == null) {
                        print("❌ URL tidak valid: $urlMaps");
                        return;
                      }

                      // Cek apakah bisa dibuka
                      final canOpen = await canLaunchUrl(uri);
                      print("🔍 Can launch URL? $canOpen");

                      if (canOpen) {
                        await launchUrl(
                          uri,
                          mode: LaunchMode.externalApplication,
                        );
                        print("✅ Berhasil membuka Google Maps");
                      } else {
                        print("❌ Could not open the map.");
                      }
                    } catch (e) {
                      print("🔥 Error launching URL: $e");
                    }
                  },
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppColors.deepOceanBlue,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(10),
                    // margin: EdgeInsets.only(left: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            location?.name ?? '',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),
                        ),
                        Icon(Icons.location_on, color: Colors.white, size: 50),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      });
    }

    Widget buttonAttendance() {
      return Obx(() {
        final coach = controller.scheduleResponse.value?.coach;
        final isCoachAttendanceNull = coach?.attendanceStatus == null;

        // Tentukan warna tombol berdasarkan status kehadiran coach
        Color buttonColor;
        if (coach?.attendanceStatus == "Hadir") {
          buttonColor = Colors.green; // Warna hijau untuk "Hadir"
        } else if (coach?.attendanceStatus == "Tidak Hadir") {
          buttonColor = Colors.red; // Warna merah untuk "Tidak Hadir"
        } else {
          buttonColor = AppColors.deepOceanBlue; // Warna default
        }

        return Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:
                      isCoachAttendanceNull
                          ? () {
                            Get.toNamed(
                              '/presence-coach',
                              arguments: {
                                'scheduleId':
                                    controller
                                        .scheduleResponse
                                        .value
                                        ?.schedule
                                        ?.id,
                              },
                            );
                          }
                          : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor, // Warna tombol
                    foregroundColor: Colors.white, // Warna teks tombol
                    disabledBackgroundColor:
                        buttonColor, // Warna tombol saat nonaktif
                    disabledForegroundColor:
                        Colors.white, // Warna teks saat tombol nonaktif
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    coach?.attendanceStatus == "Hadir"
                        ? 'Coach Hadir'
                        : coach?.attendanceStatus == "Tidak Hadir"
                        ? 'Coach Tidak Hadir'
                        : 'Absensi Coach',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:
                      coach?.attendanceStatus == "Hadir" &&
                              controller.scheduleResponse.value?.students?.any(
                                    (student) =>
                                        student.attendanceStatus == null,
                                  ) ==
                                  true
                          ? () {
                            Get.toNamed(
                              '/presence-student',
                              arguments: {
                                'scheduleId':
                                    controller
                                        .scheduleResponse
                                        .value
                                        ?.schedule
                                        ?.id,
                              },
                            );
                          }
                          : null, // Disable button if all students have been marked
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        controller.scheduleResponse.value?.students?.any(
                                  (student) => student.attendanceStatus == null,
                                ) ==
                                false
                            ? Colors
                                .green // Green if all students are marked
                            : AppColors.deepOceanBlue, // Default color
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    controller.scheduleResponse.value?.students?.any(
                              (student) => student.attendanceStatus == null,
                            ) ==
                            false
                        ? 'Absensi Siswa Selesai' // Text when all students are marked
                        : 'Absensi Siswa', // Default text
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      });
    }

    Widget listSiswa() {
      return Obx(() {
        final students = controller.scheduleResponse.value?.students ?? [];
        return Container(
          padding: EdgeInsets.all(16.0),
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.account_circle, color: AppColors.deepOceanBlue),
                  SizedBox(width: 8),
                  Text(
                    'Daftar Siswa',
                    style: GoogleFonts.poppins(
                      color: AppColors.deepOceanBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              ...students.map((student) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${students.indexOf(student) + 1}. ${student.name}',
                      style: GoogleFonts.poppins(
                        color: AppColors.deepOceanBlue,
                        fontWeight: FontWeightStyles.semiBold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color:
                                    student.attendanceStatus == "Hadir"
                                        ? AppColors.lightGreen
                                        : Colors.white,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 16.0,
                              ),
                              child: Center(
                                child: Text(
                                  'Hadir',
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color:
                                    student.attendanceStatus == "Tidak Hadir"
                                        ? AppColors.softRed
                                        : Colors.white,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 16.0,
                              ),
                              child: Center(
                                child: Text(
                                  'Tidak Hadir',
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Obx(() {
                        if (controller.scheduleResponse.value?.schedule?.isAssessed == 1) {
                          return SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: student.attendanceStatus == null
                                  ? null // Disable button if attendanceStatus is null
                                  : () {
                                      Get.toNamed(
                                        '/form-penilaian', // Ganti dengan route form penilaian Anda
                                        arguments: {
                                          'scheduleId': controller.scheduleResponse.value?.schedule?.id,
                                          'studentId': student.id, // Pastikan Anda memiliki ID siswa
                                        },
                                      );
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: student.attendanceStatus == null
                                    ? Colors.grey // Disabled button color
                                    : AppColors.deepOceanBlue, // Active button color
                                padding: EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 16.0,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                'Beri Penilaian',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        } else {
                          return SizedBox.shrink(); // Hidden if isAssessed == 0
                        }
                      }),
                    ),
                  ],
                );
              }).toList(),
            ],
          ),
        );
      });
    }

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            Text(
              "Kembali",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Obx(() {
                if (controller.scheduleResponse.value?.schedule?.status ==
                    "rescheduled") {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      "Reschedule",
                      style: GoogleFonts.poppins(
                        color: AppColors.deepOceanBlue,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                } else {
                  return SizedBox.shrink(); // Tidak menampilkan apapun
                }
              }),
            ),
          ],
        ),
        backgroundColor: AppColors.deepOceanBlue,
        iconTheme: const IconThemeData(color: Colors.white),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark, // Set icons to dark (gray)
          statusBarColor:
              Colors.transparent, // Optional: Make status bar transparent
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [header(), location(), buttonAttendance(), listSiswa()],
        ),
      ),
    );
  }
}
