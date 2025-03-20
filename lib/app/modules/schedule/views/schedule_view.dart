import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mob_dev_wave_coach/app/core/values/app_colors.dart';
import '../controllers/schedule_controller.dart';

class ScheduleView extends StatefulWidget {
  const ScheduleView({super.key});

  @override
  _ScheduleViewState createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  final List<String> monthNames = [
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
                        Text(
                          'Welcome Sarah',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'poppins_medium',
                            fontSize: 14,
                            letterSpacing: -0.3,
                          ),
                        ),
                        // SizedBox(height: 12),
                        Text(
                          'Stay Strong Coach!',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'poppins_medium',
                            fontSize: 20,
                            letterSpacing: -0.3,
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
      return Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(width: 20),
                  Row(
                    children: List.generate(13, (index) {
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
                                color: Colors.grey.withValues(alpha: 0.5),
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
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'poppins_medium',
                              color:
                                  _selectedMonthIndex == index
                                      ? Colors.white
                                      : Colors.black,
                            ),
                          ),
                        ),
                      );
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
                  color: Colors.grey.withValues(alpha: 0.5),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: Offset(0, 4), // changes position of shadow
                ),
              ],
            ),
            child: Text(
              'History',
              style: TextStyle(fontSize: 16, fontFamily: 'poppins_medium'),
            ),
          ),
        ],
      );
    }

    Widget listJadwal() {
      return Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.scheduleList.isEmpty) {
          return const Center(child: Text("No schedules available"));
        }

        return ListView.builder(
          itemCount: controller.scheduleList.length,
          itemBuilder: (context, index) {
            final schedule = controller.scheduleList[index];
            return SingleChildScrollView(
              child: Card(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 15),
                child: ListTile(
                  leading: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: AppColors.deepOceanBlue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  title: Text(
                    schedule.formattedDate,
                    style: const TextStyle(fontWeight: FontWeight.w400),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Time: ${schedule.startTime} - ${schedule.endTime}"),
                      Text("Location: ${schedule.locationName}"),
                      SizedBox(height: 10),
                    ],
                  ),
                  onTap: () {
                    Get.toNamed('/schedule_detail', arguments: schedule);
                  },
                ),
              ),
            );
          },
        );
      });
    }

    return Scaffold(
      backgroundColor: AppColors.skyBlue,
      body: Column(
        children: [
          header(),
          SizedBox(height: 15),
          textJadwalLatihan(),
          monthAndHistoryButton(),
          Expanded(
            child: listJadwal(),
          ), // Wrap listJadwal with Expanded to avoid overflow
        ],
      ),
    );
  }
}
