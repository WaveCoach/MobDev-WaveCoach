import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mob_dev_wave_coach/app/modules/notification/model/notification_model.dart';

import '../controllers/notification_controller.dart';

class NotificationView extends StatefulWidget {
  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  final NotificationController controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('NotificationView'), centerTitle: true),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.notificationList.isEmpty) {
          return Center(child: Text('No notifications found'));
        }

        return ListView.builder(
          itemCount: controller.notificationList.length,
          itemBuilder: (context, index) {
            NotificationModel notification = controller.notificationList[index];
            return ListTile(
              leading: Icon(Icons.notifications),
              title: Text(notification.title),
              subtitle: Text(
                "Dari: ${notification.pengirim.name}\n${notification.message}",
              ),
              trailing: Text(notification.createdAt),
            );
          },
        );
      }),
    );
  }
}
