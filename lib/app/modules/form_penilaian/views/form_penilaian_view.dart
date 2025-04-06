import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_dev_wave_coach/app/modules/form_penilaian/model/student_model.dart';
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
      body: SingleChildScrollView(
        // agar bisa scroll saat konten tinggi
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Input tanggal
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
                        "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";

                    // Fetch schedule setelah pilih tanggal
                    await formPenilaianController.fetchSchedulesByDate(
                      date: formPenilaianController.dateController.text,
                    );
                  }
                },
              ),
              SizedBox(height: 16),

              // Dropdown schedule
              Obx(() {
                if (scheduleController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }
                if (scheduleController.scheduleList.isEmpty) {
                  return Center(child: Text("Tidak ada jadwal tersedia"));
                }
                return DropdownButtonFormField<Schedule>(
                  isExpanded: true,
                  value: formPenilaianController.selectedSchedule.value,
                  items:
                      scheduleController.scheduleList.map((schedule) {
                        return DropdownMenuItem(
                          value: schedule,
                          child: Text(
                            "${schedule.date} | ${schedule.startTime} - ${schedule.endTime}",
                            style: TextStyle(fontSize: 14),
                          ),
                        );
                      }).toList(),
                  onChanged: (schedule) {
                    formPenilaianController.selectedSchedule.value = schedule;
                    formPenilaianController.fetchStudentBySchedule();
                  },
                  decoration: InputDecoration(
                    labelText: "Pilih Jadwal",
                    border: OutlineInputBorder(),
                  ),
                );
              }),

              SizedBox(height: 16),
              Obx(() {
                if (formPenilaianController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }

                if (formPenilaianController.studentList.isEmpty) {
                  return Center(child: Text("Tidak ada siswa tersedia"));
                }

                return DropdownButtonFormField<Student>(
                  isExpanded: true,
                  decoration: InputDecoration(
                    labelText: "Pilih Siswa",
                    border: OutlineInputBorder(),
                  ),
                  value: formPenilaianController.selectedStudent.value,
                  items:
                      formPenilaianController.studentList.map((student) {
                        return DropdownMenuItem<Student>(
                          value: student,
                          child: Text(student.name),
                        );
                      }).toList(),
                  onChanged: (Student? newValue) {
                    formPenilaianController.selectedStudent.value = newValue;
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
