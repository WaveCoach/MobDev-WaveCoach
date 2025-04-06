import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mob_dev_wave_coach/app/modules/form_penilaian/model/student_model.dart';
import 'package:mob_dev_wave_coach/app/modules/form_penilaian/model/swim_style_model.dart';
import 'package:mob_dev_wave_coach/app/modules/schedule/controllers/schedule_controller.dart';
import 'package:mob_dev_wave_coach/app/modules/schedule/model/schedule_response.dart';
import '../controllers/form_penilaian_controller.dart';

class FormPenilaianView extends GetView<FormPenilaianController> {
  FormPenilaianView({Key? key}) : super(key: key);
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
            const SizedBox(height: 16),
            _buildSwimStyleDropdown(),
            const SizedBox(height: 16),
            _buildAspectAssessment(),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return TextFormField(
      controller: controller.dateController,
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
          controller.dateController.text = formattedDate;
          await controller.fetchSchedulesByDate(date: formattedDate);
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
        value: controller.selectedSchedule.value,
        decoration: const InputDecoration(
          labelText: "Pilih Jadwal",
          border: OutlineInputBorder(),
        ),
        items:
            scheduleController.scheduleList.map<DropdownMenuItem<Schedule>>((
              schedule,
            ) {
              return DropdownMenuItem<Schedule>(
                value: schedule,
                child: Text(
                  "${schedule.date} | ${schedule.startTime} - ${schedule.endTime}",
                ),
              );
            }).toList(),
        onChanged: (selectedSchedule) {
          controller.selectedSchedule.value = selectedSchedule;
          controller.fetchStudentBySchedule();
        },
      );
    });
  }

  Widget _buildStudentDropdown() {
    return Obx(() {
      return DropdownButtonFormField<Student>(
        isExpanded: true,
        value: controller.selectedStudent.value,
        decoration: const InputDecoration(
          labelText: "Pilih Siswa",
          border: OutlineInputBorder(),
        ),
        items:
            controller.studentList.map<DropdownMenuItem<Student>>((student) {
              return DropdownMenuItem<Student>(
                value: student,
                child: Text(student.name),
              );
            }).toList(),
        onChanged: (selectedStudent) {
          controller.selectedStudent.value = selectedStudent;
        },
      );
    });
  }

  Widget _buildSwimStyleDropdown() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.swimStyleList.isEmpty) {
        return const Center(child: Text("Tidak ada gaya renang tersedia"));
      }

      return DropdownButtonFormField<SwimStyle>(
        isExpanded: true,
        value: controller.selectedSwimStyle.value,
        decoration: const InputDecoration(
          labelText: "Pilih Gaya Renang",
          border: OutlineInputBorder(),
        ),
        items:
            controller.swimStyleList.map<DropdownMenuItem<SwimStyle>>((
              swimStyle,
            ) {
              return DropdownMenuItem<SwimStyle>(
                value: swimStyle,
                child: Text(swimStyle.name),
              );
            }).toList(),
        onChanged: (selectedSwimStyle) {
          controller.selectedSwimStyle.value = selectedSwimStyle;
        },
      );
    });
  }

  Widget _buildAspectAssessment() {
    final List<Map<String, dynamic>> aspekList = [
      {
        'id': 1,
        'name': 'Kecepatan',
        'desc': 'Seberapa cepat siswa berenang dalam gaya ini.',
      },
      {
        'id': 2,
        'name': 'Ketahanan',
        'desc': 'Kemampuan siswa mempertahankan stamina.',
      },
    ];

    final Map<int, TextEditingController> _controllers = {
      1: TextEditingController(),
      2: TextEditingController(),
    };

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: aspekList.length,
      itemBuilder: (context, index) {
        final aspek = aspekList[index];
        return ExpansionTile(
          title: Text(aspek['name']),
          subtitle: Text(aspek['desc'] ?? ''),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  TextField(
                    controller: _controllers[aspek['id']],
                    decoration: InputDecoration(
                      labelText: "Nilai ${aspek['name']}",
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Catatan ${aspek['name']}",
                      border: const OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
