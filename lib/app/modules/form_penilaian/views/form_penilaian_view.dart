import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_dev_wave_coach/app/modules/form_penilaian/model/student_model.dart';
import 'package:mob_dev_wave_coach/app/modules/schedule/controllers/schedule_controller.dart';
import 'package:mob_dev_wave_coach/app/modules/schedule/model/schedule_response.dart';
import '../controllers/form_penilaian_controller.dart';

class FormPenilaianView extends GetView<FormPenilaianController> {
  final FormPenilaianController penilaianController = Get.put(
    FormPenilaianController(),
  );
  final ScheduleController scheduleController = Get.find<ScheduleController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Form Penilaian")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDatePicker(context),
            const SizedBox(height: 16),
            _buildScheduleDropdown(),
            const SizedBox(height: 16),
            _buildStudentDropdown(),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return TextFormField(
      controller: penilaianController.dateController,
      decoration: const InputDecoration(
        labelText: "Tanggal",
        border: OutlineInputBorder(),
        suffixIcon: Icon(Icons.calendar_today),
      ),
      readOnly: true,
      onTap: () async {
        final pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (pickedDate != null) {
          final formattedDate =
              "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
          penilaianController.dateController.text = formattedDate;

          await penilaianController.fetchSchedulesByDate(date: formattedDate);
        }
      },
    );
  }

  Widget _buildScheduleDropdown() {
    return Obx(() {
      if (scheduleController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (scheduleController.scheduleList.isEmpty) {
        return const Center(child: Text("Tidak ada jadwal tersedia"));
      }

      return DropdownButtonFormField<Schedule>(
        isExpanded: true,
        value: penilaianController.selectedSchedule.value,
        decoration: const InputDecoration(
          labelText: "Pilih Jadwal",
          border: OutlineInputBorder(),
        ),
        items:
            scheduleController.scheduleList.map((schedule) {
              return DropdownMenuItem(
                value: schedule,
                child: Text(
                  "${schedule.date} | ${schedule.startTime} - ${schedule.endTime}",
                  style: const TextStyle(fontSize: 14),
                ),
              );
            }).toList(),
        onChanged: (selectedSchedule) {
          penilaianController.selectedSchedule.value = selectedSchedule;
          penilaianController.fetchStudentBySchedule();
        },
      );
    });
  }

  Widget _buildStudentDropdown() {
    return Obx(() {
      if (penilaianController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (penilaianController.studentList.isEmpty) {
        return const Center(child: Text("Tidak ada siswa tersedia"));
      }

      return DropdownButtonFormField<Student>(
        isExpanded: true,
        value: penilaianController.selectedStudent.value,
        decoration: const InputDecoration(
          labelText: "Pilih Siswa",
          border: OutlineInputBorder(),
        ),
        items:
            penilaianController.studentList.map((student) {
              return DropdownMenuItem(
                value: student,
                child: Text(student.name),
              );
            }).toList(),
        onChanged: (selectedStudent) {
          penilaianController.selectedStudent.value = selectedStudent;
        },
      );
    });
  }
}
