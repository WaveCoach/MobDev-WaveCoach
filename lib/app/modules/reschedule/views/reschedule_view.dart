import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_dev_wave_coach/app/core/values/app_colors.dart';
import 'package:mob_dev_wave_coach/app/modules/reschedule/controllers/reschedule_controller.dart';

class RescheduleView extends StatelessWidget {
  final RescheduleController controller = RescheduleController();
  final TextEditingController reasonController = TextEditingController();
  RescheduleView({super.key});

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
                        padding: const EdgeInsets.only(
                          top: 100,
                          left: 35,
                          right: 35,
                        ),
                        child: Text(
                          "Form Reschedule Jadwal",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "poppins_semibold",
                            fontSize: 32,
                            color: Colors.white,
                            height: 1,
                            letterSpacing: -0.5,
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
                              Get.back(result: true); // Kirim sinyal untuk refresh
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
                      "Alasan",
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
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: reasonController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Ketik disini',
                      ),
                    ),
                  ),
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
            String reason = reasonController.text.trim();
            if (reason.isNotEmpty) {
              controller.sendRescheduleRequest(reason);
              Get.back(result: true); // Kirim sinyal untuk refresh setelah upload
            } else {
              Get.snackbar("Error", "Reason cannot be empty");
            }
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
