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
  bool _isHistorySelected = false; // Variabel baru untuk menandai "History"

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
                      child: Stack(
                        children: [
                          Icon(
                            Icons.notifications,
                            color: Colors.white,
                            size: 40,
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Obx(() {
                              if (controller.unreadNotificationCount.value >
                                  0) {
                                return Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    controller.unreadNotificationCount.value >
                                            99
                                        ? '99+'
                                        : controller
                                            .unreadNotificationCount
                                            .value
                                            .toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              } else {
                                return SizedBox.shrink(); // Hide if no unread notifications
                              }
                            }),
                          ),
                        ],
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
          final scheduleDate = DateTime.parse(
            schedule.date,
          ); // Assuming `schedule.date` is in ISO format
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
                        if (index == 0 ||
                            index == 1 ||
                            availableMonths.contains(index - 1)) {
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
                                color:
                                    _selectedMonthIndex == index
                                        ? AppColors.deepOceanBlue
                                        : Colors.white,
                                borderRadius: BorderRadius.circular(1000),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 0,
                                    blurRadius: 4,
                                    offset: Offset(
                                      0,
                                      4,
                                    ), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Text(
                                monthNames[index],
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500, // Medium
                                  fontSize: 16,
                                  color:
                                      _selectedMonthIndex == index
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
            GestureDetector(
              onTap: () {
                setState(() {
                  _isHistorySelected =
                      !_isHistorySelected; // Toggle history selection
                });
                if (_isHistorySelected) {
                  _selectedMonthIndex = 0;
                  controller.fetchSchedules(
                    history: true,
                  ); // Fetch history schedules
                } else {
                  _selectedMonthIndex = 0;
                  controller.fetchSchedules(); // Fetch current schedules
                }
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 15, 20, 15),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                decoration: BoxDecoration(
                  color:
                      _isHistorySelected ? AppColors.honeyGold : Colors.white,
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
                    color: _isHistorySelected ? Colors.white : Colors.black,
                  ),
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
      return RefreshIndicator(
        onRefresh: () async {
          if (_isHistorySelected) {
            await controller.fetchSchedules(history: true);
          } else {
            await controller.refreshScheduleList();
          }
        },
        child: Center( // Membungkus ListView dengan Center agar pesan berada di tengah
          child: ListView(
            shrinkWrap: true, // Agar ListView hanya sebesar kontennya
            children: const [
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    "No schedules available",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

        // Filter schedule list based on the selected month index and history
        List filteredScheduleList =
            controller.scheduleList.where((schedule) {
              final scheduleDate = DateTime.parse(schedule.date);
              final scheduleMonth = scheduleDate.month;

              // Filter berdasarkan bulan
              bool isMonthMatch = false;
              if (_selectedMonthIndex == 0) {
                final now = DateTime.now();
                final todayStart = DateTime(now.year, now.month, now.day);
                final todayEnd = todayStart.add(Duration(days: 1));

                if (_isHistorySelected) {
                  // Filter "Terdekat" (3 hari ke belakang termasuk hari ini)
                  isMonthMatch =
                      scheduleDate.isBefore(todayEnd) &&
                      scheduleDate.isAfter(
                        todayStart.subtract(Duration(days: 3)),
                      );
                } else {
                  // Filter "Terdekat" (hari ini dan 3 hari ke depan)
                  isMonthMatch =
                      scheduleDate.isAfter(
                        todayStart.subtract(Duration(days: 1)),
                      ) &&
                      scheduleDate.isBefore(todayEnd.add(Duration(days: 3)));
                }
              } else if (_selectedMonthIndex == 1) {
                if (_isHistorySelected) {
                  // Filter "Semua" dengan History aktif
                  isMonthMatch = true;
                } else {
                  // Filter "Semua" dengan History nonaktif
                  final now = DateTime.now();
                  final todayStart = DateTime(now.year, now.month, now.day);
                  isMonthMatch =
                      scheduleDate.isAfter(
                        todayStart.subtract(Duration(days: 1)),
                      ) ||
                      scheduleDate.isAtSameMomentAs(now);
                }
              } else {
                // Filter berdasarkan bulan tertentu
                isMonthMatch = scheduleMonth == _selectedMonthIndex - 1;
              }

              // Jika tombol "History" aktif, tambahkan filter untuk jadwal yang sudah berlalu
              if (_isHistorySelected) {
                return isMonthMatch && scheduleDate.isBefore(DateTime.now());
              }

              // Jika tombol "History" tidak aktif, gunakan filter bulan saja
              return isMonthMatch;
            }).toList();

        // Tampilkan pesan jika tidak ada jadwal yang sesuai
        if (filteredScheduleList.isEmpty) {
          return const Center(
            child: Text(
              "Tidak ada jadwal yang sesuai",
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
            if (_isHistorySelected) {
              await controller.fetchSchedules(history: true);
            } else {
              await controller.refreshScheduleList();
            }
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
                      color: AppColors.softSteelBlue,
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
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          if (schedule.status == "rescheduled")
                                            Container(
                                              width: 20, // Lebar lingkaran
                                              height: 20, // Tinggi lingkaran
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape:
                                                    BoxShape
                                                        .circle, // Membuat bentuk lingkaran
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "R", // Inisial huruf
                                                  style: GoogleFonts.poppins(
                                                    fontWeight:
                                                        FontWeight.w600, // Bold
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          SizedBox(width: 5),
                                          if (schedule.isAssessed == 1)
                                            Container(
                                              width: 20, // Lebar lingkaran
                                              height: 20, // Tinggi lingkaran
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape:
                                                    BoxShape
                                                        .circle, // Membuat bentuk lingkaran
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons
                                                      .description, // Ikon dokumen
                                                  size: 12,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                        ],
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
