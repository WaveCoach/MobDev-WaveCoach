import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mob_dev_wave_coach/app/core/values/app_colors.dart';
import '../controllers/schedule_detail_controller.dart';

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
          height: 420,
          decoration: BoxDecoration(
            color: AppColors.deepOceanBlue,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                day, // Hanya angka tanggal
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 200,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                monthYear, // "Mei 2025"
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.w700,
                ),
              ),
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
          padding: EdgeInsets.all(16.0),
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
                  margin: EdgeInsets.only(right: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.access_time_filled,
                              color: AppColors.deepOceanBlue,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Pelaksanaan',
                              style: GoogleFonts.poppins(
                                color: AppColors.deepOceanBlue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${schedule?.startTime?.substring(0, 5)} - ${schedule?.endTime?.substring(0, 5)}',
                              style: GoogleFonts.poppins(
                                color: AppColors.deepOceanBlue,
                                fontSize: 24,
                                fontWeight: FontWeightStyles.medium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
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
                  padding: EdgeInsets.all(8.0),
                  margin: EdgeInsets.only(left: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          location?.name ?? '',
                          style: GoogleFonts.poppins(color: Colors.white),
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
            ],
          ),
        );
      });
    }

    Widget buttonAttendance() {
      return Obx(() {
        final coach = controller.scheduleResponse.value?.coach;
        final isCoachAttendanceNull = coach?.attendanceStatus == null;

        return Container(
          padding: EdgeInsets.all(16.0),
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
                    backgroundColor: AppColors.deepOceanBlue,
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Absensi Coach',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:
                      isCoachAttendanceNull
                          ? null
                          : () {
                            // Add your onPressed code here!
                          },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.deepOceanBlue,
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Absensi Siswa',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
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
          margin: EdgeInsets.all(16.0),
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
                      student.name,
                      style: GoogleFonts.poppins(
                        color: AppColors.deepOceanBlue,
                        fontWeight: FontWeightStyles.semiBold,
                        fontSize: 18,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // Add your onPressed code here!
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  student.attendanceStatus == null
                                      ? Colors.white
                                      : AppColors.lightGreen,
                              padding: EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 16.0,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(color: Colors.black, width: 1),
                              ),
                            ),
                            child: Text(
                              'Hadir',
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // Add your onPressed code here!
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  student.attendanceStatus == null
                                      ? Colors.white
                                      : AppColors.softRed,
                              padding: EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 16.0,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(color: Colors.black, width: 1),
                              ),
                            ),
                            child: Text(
                              'Tidak Hadir',
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Add your onPressed code here!
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.deepOceanBlue,
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
                    ),
                    SizedBox(height: 16.0),
                  ],
                );
              }).toList(),
            ],
          ),
        );
      });
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [header(), location(), buttonAttendance(), listSiswa()],
        ),
      ),
    );
  }
}
