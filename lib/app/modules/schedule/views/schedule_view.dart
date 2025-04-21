import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mob_dev_wave_coach/app/core/values/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Tambahkan ini untuk mendukung SVG
import '../controllers/schedule_controller.dart';

class ScheduleView extends StatefulWidget {
  const ScheduleView({super.key});

  @override
  _ScheduleViewState createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  final List<String> monthNames = [
    'Terdekat',
    'Semua',
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'July',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  int _selectedMonthIndex = 0;
  final ScheduleController controller = Get.put(ScheduleController());

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
            child: Container(
              color: AppColors.deepOceanBlue,
              width: MediaQuery.of(context).size.width,
              height: 150,
              child: Stack(
                children: [
                  Positioned(
                    bottom: 30,
                    left: 30,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => Text(
                            'Welcome ${controller.name.value}',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.white,
                              letterSpacing: -0.3,
                            ),
                          ),
                        ),
                        Text(
                          'Stay Strong Coach!',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.white,
                            letterSpacing: -0.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    right: 30,
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed('/notification');
                      },
                      child: Icon(
                        Icons.notifications,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    Widget textJadwalLatihan() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Jadwal Latihan',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: 40,
              color: AppColors.midnightNavy,
              letterSpacing: -0.5,
            ),
          ),
        ),
      );
    }

    Widget monthAndHistoryButton() {
      return Obx(() {
        // Filter months that have schedules
        List<int> availableMonths = [];
        for (var schedule in controller.scheduleList) {
          final scheduleDate = DateTime.parse(schedule.date); // Assuming `schedule.date` is in ISO format
          final scheduleMonth = scheduleDate.month;
          if (!availableMonths.contains(scheduleMonth)) {
            availableMonths.add(scheduleMonth);
          }
        }

        return Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(width: 20),
                    Row(
                      children: List.generate(monthNames.length, (index) {
                        // Show button only if the month is available or it's "Terdekat" or "Semua"
                        if (index == 0 || index == 1 || availableMonths.contains(index - 1)) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedMonthIndex = index;
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 2.5,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 7,
                              ),
                              decoration: BoxDecoration(
                                color: _selectedMonthIndex == index
                                    ? AppColors.deepOceanBlue
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(1000),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 0,
                                    blurRadius: 4,
                                    offset: Offset(0, 4), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Text(
                                monthNames[index],
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500, // Medium
                                  fontSize: 16,
                                  color: _selectedMonthIndex == index
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          );
                        } else {
                          return SizedBox.shrink(); // Hide button if the month is not available
                        }
                      }),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(width: 1, height: 40, color: Colors.grey),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 15, 20, 15),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0,
                    blurRadius: 4,
                    offset: Offset(0, 4), // changes position of shadow
                  ),
                ],
              ),
              child: Text(
                'History',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500, // Medium
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        );
      });
    }

    Widget listJadwal() {
      return Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.scheduleList.isEmpty) {
          return const Center(child: Text("No schedules available"));
        }

        // Filter schedule list based on the selected month index
        List filteredScheduleList =
            controller.scheduleList.where((schedule) {
              if (_selectedMonthIndex == -1) {
                // Jangan filter apapun, karena data sudah dari endpoint history
                return true;
              } else if (_selectedMonthIndex == 0) {
                final now = DateTime.now();
                final scheduleDate = DateTime.parse(schedule.date);
                return scheduleDate.isAfter(now) &&
                    scheduleDate.isBefore(now.add(Duration(days: 3)));
              } else if (_selectedMonthIndex == 1) {
                return true; // semua
              } else {
                final scheduleMonth = DateTime.parse(schedule.date).month;
                return scheduleMonth == _selectedMonthIndex - 1;
              }
            }).toList();

        // Check if "Terdekat" is selected and no schedules are available
        if (_selectedMonthIndex == 0 && filteredScheduleList.isEmpty) {
          return const Center(
            child: Text(
              "Tidak ada jadwal rentang 3 Hari terdekat",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            // Call your refresh function here
            await controller.refreshScheduleList();
          },
          child: ListView.builder(
            padding: EdgeInsets.only(bottom: 120), // Add padding to the bottom
            itemCount: filteredScheduleList.length,
            itemBuilder: (context, index) {
              final schedule = filteredScheduleList[index];
              return Padding(
                padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(
                      '/schedule-detail',
                      arguments: {'id': schedule.id},
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color:
                          schedule.isAssessed == 1
                              ? AppColors.pastelBlue
                              : AppColors.softSteelBlue,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Container(
                              width: 75,
                              height: 75,
                              decoration: BoxDecoration(
                                color: AppColors.deepOceanBlue,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        schedule.formattedDate
                                            .split(',')[1]
                                            .trim()
                                            .substring(0, 2),
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 47,
                                          color: Colors.white,
                                          height: 0.9,
                                        ),
                                      ),
                                    ),
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        schedule.formattedDate
                                            .split(',')[1]
                                            .trim()
                                            .substring(2)
                                            .replaceAll(RegExp(r'\d'), '')
                                            .trim(),
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 11,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                    bottom: 5,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.goldenAmber,
                                          borderRadius: BorderRadius.circular(
                                            1000,
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8,
                                        ),
                                        child: Text(
                                          "${schedule.startTime.substring(0, 5)} - ${schedule.endTime.substring(0, 5)} WIB", // Jam Mulai dan Akhir
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Expanded(child: Container()),
                                      if (schedule.status == "rescheduled")
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              1000,
                                            ),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 8,
                                          ),
                                          child: Text(
                                            "R",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color: AppColors.deepOceanBlue,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                Text(
                                  schedule
                                      .formattedDate, // Hari, Tanggal, Bulan, Tahun
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 5,
                                    bottom: 10,
                                  ),
                                  child: Text(
                                    schedule.locationName,
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
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
      });
    }

    Widget wavePattern() {
      return Positioned(
        top: 0,
        bottom: 0,
        left: 0,
        right: 0,
        child: SvgPicture.asset(
          'assets/images/WavePattern.svg',
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
          color: Colors.black.withOpacity(0.04), // Set opacity to 3%
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.skyBlue,
      body: Stack(
        children: [
          wavePattern(), // Tambahkan SVG di bagian bawah
          Column(
            children: [
              header(),
              SizedBox(height: 15),
              textJadwalLatihan(),
              monthAndHistoryButton(),
              Expanded(child: listJadwal()),
            ],
          ),
        ],
      ),
    );
  }
}
