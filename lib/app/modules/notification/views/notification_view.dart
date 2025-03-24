import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mob_dev_wave_coach/app/core/values/app_colors.dart';
import 'package:mob_dev_wave_coach/app/modules/notification/model/notification_model.dart';
import '../controllers/notification_controller.dart';

class NotificationView extends StatefulWidget {
  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  final NotificationController controller = Get.put(NotificationController());

  Future<void> _refreshNotifications() async {
    controller.fetchNotifications();
  }

  Widget header() {
    return Container(
      height: 230,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.deepOceanBlue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 70,
            left: 15,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Row(
                children: [
                  Icon(Icons.arrow_back, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    "Kembali",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Text(
                "Notification",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget listNotification() {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }

      if (controller.notificationList.isEmpty) {
        return Center(child: Text('No notifications found'));
      }

      return RefreshIndicator(
        onRefresh: _refreshNotifications,
        child: ListView.builder(
          itemCount: controller.notificationList.length,
          itemBuilder: (context, index) {
            NotificationModel notification = controller.notificationList[index];
            return Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
                child: GestureDetector(
                  // onTap: () {

                  // },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 0), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/coachSarah.jpg',
                                width: 45,
                                height: 45,
                                fit: BoxFit.cover,
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
                                  child: Text(
                                    notification.pengirim.name,
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: -0.3
                                    ),
                                  ),
                                ),
                                Text(
                                  notification.title,
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: -0.3
                                    ),
                                ),
                                Text(
                                  notification.message,
                                  style: GoogleFonts.poppins(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: -0.3
                                    ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 5,
                                    bottom: 10,
                                  ),
                                  child: Text(
                                    notification.createdAt,
                                    style: GoogleFonts.poppins(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: -0.3
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
              ),
            );
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.skyBlue,
      body: Column(children: [header(), Expanded(child: listNotification())]),
    );
  }
}
