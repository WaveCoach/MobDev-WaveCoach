import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_dev_wave_coach/app/core/values/app_colors.dart';
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
  bool showBuktiKehadiranButton = false;
  bool showAlasanTidakHadir = false; // New state variable

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(0),
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
                            icon: Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          Text(
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
                  SizedBox(height: 20),
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
                                showBuktiKehadiranButton = true;
                                showAlasanTidakHadir =
                                    false; // Hide alasan tidak hadir
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: hadirButtonColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
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
                      SizedBox(width: 10),
                      Expanded(
                        child: SizedBox(
                          height: 70,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                hadirButtonColor = Colors.white;
                                tidakHadirButtonColor = Colors.red;
                                showBuktiKehadiranButton = false;
                                showAlasanTidakHadir =
                                    true; // Show alasan tidak hadir
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: tidakHadirButtonColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
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
                  if (showBuktiKehadiranButton) ...[
                    SizedBox(height: 50),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: AppColors.deepOceanBlue,
                      ),
                      child: Text(
                        "Ambil Gambar",
                        style: TextStyle(
                          fontFamily: "poppins_semibold",
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Center(
                        child: SizedBox(
                          height: 70,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.goldenAmber,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
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
                    ),
                  ],
                  if (showAlasanTidakHadir) ...[
                    SizedBox(height: 50),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: AppColors.deepOceanBlue,
                      ),
                      child: Text(
                        "Alasan Tidak Hadir",
                        style: TextStyle(
                          fontFamily: "poppins_semibold",
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withAlpha(128),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: TextField(
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
      floatingActionButton: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ElevatedButton(
          onPressed: () {
            // Tambahkan aksi yang diinginkan di sini
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
