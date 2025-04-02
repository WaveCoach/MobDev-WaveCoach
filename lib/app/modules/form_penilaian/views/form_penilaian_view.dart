import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_dev_wave_coach/app/modules/schedule/controllers/schedule_controller.dart';
import 'package:mob_dev_wave_coach/app/modules/schedule/model/schedule_response.dart';

import '../controllers/form_penilaian_controller.dart';

class FormPenilaianView extends GetView<FormPenilaianController> {
  final formPenilaianController = Get.put(FormPenilaianController());
  final scheduleController = Get.find<ScheduleController>();
  final TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Form Penilaian")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //inputan tanggal
            TextFormField(
              controller: formPenilaianController.dateController,
              decoration: InputDecoration(
                labelText: "Tanggal",
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  formPenilaianController.dateController.text =
                      "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";

                  // Setelah memilih tanggal, panggil API untuk mengambil jadwal
                  await formPenilaianController.fetchSchedulesByDate(
                    date: formPenilaianController.dateController.text,
                  );
                }
              },
            ),
            SizedBox(height: 16),
            //inputan schedule
            Obx(() {
              if (scheduleController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              if (scheduleController.scheduleList.isEmpty) {
                return Center(child: Text("Tidak ada jadwal tersedia"));
              }
              return DropdownButtonFormField<Schedule>(
                value: formPenilaianController.selectedSchedule.value,
                items:
                    scheduleController.scheduleList.map((schedule) {
                      return DropdownMenuItem(
                        value: schedule,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              schedule.date,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("${schedule.startTime} - ${schedule.endTime}"),
                          ],
                        ),
                      );
                    }).toList(),
                onChanged: (schedule) {
                  formPenilaianController.selectedSchedule.value = schedule;
                },
                decoration: InputDecoration(
                  labelText: "Pilih Jadwal",
                  border: OutlineInputBorder(),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
