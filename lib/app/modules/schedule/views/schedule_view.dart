import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/schedule_controller.dart';

class ScheduleView extends GetView<ScheduleController> {
  const ScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Schedule List'), centerTitle: true),
      body: Obx(() {
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
            return Card(
              margin: const EdgeInsets.all(8),
              child: ListTile(
                title: Text(
                  schedule.formattedDate,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Coach: ${schedule.coachName}"),
                    Text("Location: ${schedule.locationName}"),
                    Text("Time: ${schedule.startTime} - ${schedule.endTime}"),
                  ],
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Get.toNamed('/schedule_detail', arguments: schedule);
                },
              ),
            );
          },
        );
      }),
    );
  }
}
