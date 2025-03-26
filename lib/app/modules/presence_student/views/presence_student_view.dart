import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_dev_wave_coach/app/core/values/app_colors.dart';
import '../controllers/presence_student_controller.dart';

class PresenceStudentView extends StatefulWidget {
  const PresenceStudentView({super.key});

  @override
  _PresenceStudentViewState createState() => _PresenceStudentViewState();
}

class _PresenceStudentViewState extends State<PresenceStudentView> {
  final PresenceStudentController controller = Get.put(
    PresenceStudentController(),
  );

  // Menggunakan RxMap agar reaktif
  final RxMap<int, String> attendanceData = <int, String>{}.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 230,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.deepOceanBlue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Text(
                        "Absensi Siswa",
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
                    child: BackButton(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
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
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: AppColors.deepOceanBlue,
                    ),
                    child: Text(
                      "Presensi Kehadiran",
                      style: TextStyle(
                        fontFamily: "poppins_semibold",
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Obx(() {
                    final student =
                        controller.studentResponse.value?.students ?? [];
                    final List<Map<String, dynamic>> siswaList =
                        student
                            .map((s) => {"id": s.id, "name": s.name})
                            .toList();

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: siswaList.length,
                      itemBuilder: (context, index) {
                        final int studentId = siswaList[index]['id'];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${index + 1}. ${siswaList[index]['name']}',
                              style: TextStyle(
                                fontFamily: "poppins_medium",
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 70,
                                    child: Obx(
                                      () => ElevatedButton(
                                        onPressed: () {
                                          attendanceData[studentId] = "Hadir";
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              attendanceData[studentId] ==
                                                      "Hadir"
                                                  ? Colors.green
                                                  : Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          "Hadir",
                                          style: TextStyle(
                                            fontFamily: "poppins_regular",
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: SizedBox(
                                    height: 70,
                                    child: Obx(
                                      () => ElevatedButton(
                                        onPressed: () {
                                          attendanceData[studentId] =
                                              "Tidak Hadir";
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              attendanceData[studentId] ==
                                                      "Tidak Hadir"
                                                  ? Colors.red
                                                  : Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          "Tidak Hadir",
                                          style: TextStyle(
                                            fontFamily: "poppins_regular",
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                          ],
                        );
                      },
                    );
                  }),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ElevatedButton(
          onPressed: () {
            List<Map<String, dynamic>> studentAttendance =
                attendanceData.entries.map((entry) {
                  return {
                    "student_id": entry.key,
                    "attendance_status": entry.value,
                  };
                }).toList();

            controller.submitPresenceStudent(1, studentAttendance);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF264C6B),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(vertical: 15),
          ),
          child: Text(
            "Upload",
            style: TextStyle(
              fontFamily: "poppins_semibold",
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
