import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mob_dev_wave_coach/app/core/values/app_colors.dart';
import 'package:mob_dev_wave_coach/app/modules/form_penilaian/model/student_model.dart';
import 'package:mob_dev_wave_coach/app/modules/form_penilaian/model/swim_style_model.dart';
import 'package:mob_dev_wave_coach/app/modules/home/views/home_view.dart';
import 'package:mob_dev_wave_coach/app/modules/schedule/controllers/schedule_controller.dart';
import 'package:mob_dev_wave_coach/app/modules/schedule/model/schedule_response.dart';
import '../controllers/form_penilaian_controller.dart';

class FormPenilaianView extends StatefulWidget {
  const FormPenilaianView({Key? key}) : super(key: key);

  @override
  State<FormPenilaianView> createState() => _FormPenilaianViewState();
}

class _FormPenilaianViewState extends State<FormPenilaianView> {
  final FormPenilaianController controller =
      Get.find<FormPenilaianController>();
  final ScheduleController scheduleController = Get.find<ScheduleController>();
  TextEditingController scoreController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0, // Adjust spacing between back icon and title
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.offAll(() => HomeView(), arguments: 2);
          },
        ),
        title: Text(
          "Kembali",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: AppColors.deepOceanBlue,
        iconTheme: const IconThemeData(color: Colors.white),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark, // Set icons to dark (gray)
          statusBarColor:
              Colors.transparent, // Optional: Make status bar transparent
        ),
      ),
      backgroundColor: AppColors.skyBlue,
      body: Column(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.deepOceanBlue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Center(
              child: Text(
                "Form\nPenilaian",
                textAlign: TextAlign.center, // Set text alignment to center
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  height: 1,
                  letterSpacing: -0.5,
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      "Tanggal Latihan",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  _buildDatePicker(context),
                  const SizedBox(height: 16),
                  Obx(() {
                    // Tampilkan opsi lainnya hanya jika tanggal telah dipilih
                    if (!controller.isDateSelected.value) {
                      return const SizedBox(); // Kosongkan jika belum dipilih
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            "Jadwal Latihan",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        _buildScheduleDropdown(),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            "Nama Siswa",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        _buildStudentDropdown(),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            "Tipe Gaya Renang",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        _buildSwimStyleDropdown(),
                        const SizedBox(height: 16),
                        _buildAspectAssessment(),
                        const SizedBox(height: 30),
                        _buildSubmitButton(),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: Colors.grey),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextFormField(
          controller: controller.dateController,
          decoration: const InputDecoration(
            hintText: "Tanggal",
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none,
            suffixIcon: Icon(Icons.calendar_today),
            contentPadding: EdgeInsets.symmetric(
              vertical: 16,
            ), // Adjust vertical padding
            alignLabelWithHint: true, // Align hint text vertically
          ),
          textAlign: TextAlign.left, // Align text to the left
          textAlignVertical: TextAlignVertical.center, // Center text vertically
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 15,
            color: Colors.black,
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

              // Reset selectedSchedule, packageController, and selectedStudent
              controller.selectedSchedule.value = null;
              controller.packageController.text = ""; // Reset Kategori Kelas
              controller.selectedStudent.value = null; // Reset Nama Siswa
              controller.studentList.clear(); // Kosongkan daftar siswa

              await controller.fetchSchedulesByDate(date: formattedDate);
              controller.isDateSelected.value = true;

              // Kosongkan aspek penilaian
              controller.aspectList.clear();

              // Reset Gaya Renang
              controller.selectedSwimStyle.value = null;
            }
          },
        ),
      ),
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

      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          border: Border.all(color: Colors.black.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<Schedule>(
                isExpanded: true,
                value: controller.selectedSchedule.value,
                decoration: const InputDecoration(
                  hintText: "Pilih Jadwal",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  color: Colors.black,
                ),
                items:
                    scheduleController.scheduleList.map<
                      DropdownMenuItem<Schedule>
                    >((schedule) {
                      return DropdownMenuItem<Schedule>(
                        value: schedule,
                        child: Text(
                          "${schedule.date} | ${schedule.startTime} - ${schedule.endTime}",
                        ),
                      );
                    }).toList(),
                onChanged: (selectedSchedule) {
                  setState(() {
                    controller.selectedSchedule.value = selectedSchedule;
                    controller.packageController.text =
                        selectedSchedule?.packageName ?? '';
                    controller.selectedStudent.value = null; // Reset nama siswa
                    controller.studentList.clear(); // Kosongkan daftar siswa
                    controller
                        .fetchStudentBySchedule(); // Ambil daftar siswa baru

                    // Kosongkan aspek penilaian
                    controller.aspectList.clear();

                    // Reset Gaya Renang
                    controller.selectedSwimStyle.value = null;
                  });
                },
              ),
              const SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.deepOceanBlue,
                  border: Border.all(color: Colors.black.withOpacity(0.2)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Kategori Kelas",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: controller.packageController,
                        readOnly: true,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          hintText: "Tidak ada kategori",
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildStudentDropdown() {
    return Obx(() {
      final selectedStudent = controller.selectedStudent.value;
      final studentList = controller.studentList;

      if (selectedStudent != null &&
          !studentList.any((student) => student == selectedStudent)) {
        controller.selectedStudent.value = null;
      }

      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          border: Border.all(color: Colors.black.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: DropdownButtonFormField<Student>(
            isExpanded: true,
            value: controller.selectedStudent.value,
            decoration: const InputDecoration(
              hintText: "Pilih Siswa",
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
            ),
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize: 15,
              color: Colors.black,
            ),
            items:
                controller.studentList.map<DropdownMenuItem<Student>>((
                  student,
                ) {
                  return DropdownMenuItem<Student>(
                    value: student,
                    child: Text(student.name),
                  );
                }).toList(),
            onChanged: (selectedStudent) {
              setState(() {
                controller.selectedStudent.value = selectedStudent;

                // Kosongkan aspek penilaian
                controller.aspectList.clear();

                // Reset Gaya Renang
                controller.selectedSwimStyle.value = null;
              });
            },
          ),
        ),
      );
    });
  }

  Widget _buildSwimStyleDropdown() {
    return Obx(() {
      // Periksa apakah siswa telah dipilih
      final isStudentSelected = controller.selectedStudent.value != null;

      if (controller.swimStyleList.isEmpty) {
        return const Center(child: Text("Tidak ada gaya renang tersedia"));
      }

      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          border: Border.all(color: Colors.black.withOpacity(0.2)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: DropdownButtonFormField<SwimStyle>(
            isExpanded: true,
            value:
                isStudentSelected ? controller.selectedSwimStyle.value : null,
            decoration: InputDecoration(
              hintText: "Pilih Gaya Renang",
              hintStyle: TextStyle(
                color: Colors.grey, // Ubah warna label jika tidak aktif
              ),
              border: InputBorder.none,
            ),
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize: 15,
              color: Colors.black,
            ),
            items:
                isStudentSelected
                    ? controller.swimStyleList.map<DropdownMenuItem<SwimStyle>>(
                      (swimStyle) {
                        return DropdownMenuItem<SwimStyle>(
                          value: swimStyle,
                          child: Text(swimStyle.name),
                        );
                      },
                    ).toList()
                    : null, // Kosongkan item jika tidak aktif
            onChanged:
                isStudentSelected
                    ? (selectedSwimStyle) {
                      setState(() {
                        controller.selectedSwimStyle.value = selectedSwimStyle;
                        controller.fetchAspectSwimStyle();
                      });
                    }
                    : null, // Nonaktifkan onChanged jika tidak aktif
          ),
        ),
      );
    });
  }

  Widget _buildAspectAssessment() {
    return Obx(() {
      if (controller.aspectList.isEmpty) {
        return const Text(" ");
      }

      return Column(
        children:
            controller.aspectList.asMap().entries.map((entry) {
              final index = entry.key;
              final aspect = entry.value;

              // Buat controller baru jika belum ada
              controller.scoreControllers.putIfAbsent(
                index,
                () =>
                    TextEditingController(text: aspect.score?.toString() ?? ''),
              );

              final scoreController = controller.scoreControllers[index]!;

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: AppColors.deepOceanBlue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ExpansionTile(
                  title: Text(
                    aspect.name,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    aspect.desc ?? 'Deskripsi tidak tersedia',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  iconColor: Colors.white,
                  collapsedIconColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey, width: 0),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Nilai",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 150),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black.withOpacity(0.2),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                child: TextField(
                                  controller: scoreController,
                                  decoration: InputDecoration(
                                    hintText: "0 - 100",
                                    hintStyle: const TextStyle(
                                      color: Colors.black54,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  keyboardType: TextInputType.number,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      double? parsedValue = double.tryParse(
                                        value,
                                      );
                                      if (parsedValue != null &&
                                          (parsedValue < 0 ||
                                              parsedValue > 100)) {
                                        // Jika nilai di luar rentang, reset ke nilai sebelumnya
                                        scoreController.text = (aspect.score ??
                                                0.0)
                                            .toStringAsFixed(0);
                                        scoreController.selection =
                                            TextSelection.fromPosition(
                                              TextPosition(
                                                offset:
                                                    scoreController.text.length,
                                              ),
                                            );
                                      } else {
                                        aspect.score = parsedValue ?? 0.0;
                                      }
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Komentar",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.black.withOpacity(0.2),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText:
                                      "Catatan ${aspect.name}", // Ubah menjadi hint text
                                  hintStyle: const TextStyle(
                                    color: Colors.black54,
                                  ),
                                  border: InputBorder.none,
                                ),
                                maxLines: 3,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    aspect.remarks = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
      );
    });
  }

  Widget _buildSubmitButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: ElevatedButton(
        onPressed: () async {
          final shouldSubmit = await showDialog<bool>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  'Konfirmasi',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                content: Text(
                  'Apakah Anda yakin ingin mengirim hasil penilaian?',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context, false),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                          child: Text(
                            'Batal',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: AppColors.deepOceanBlue,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context, true),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.deepOceanBlue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                          child: Text(
                            'Kirim',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );

          if (shouldSubmit == true) {
            controller.submitAssessment();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.goldenAmber,
          minimumSize: const Size(double.infinity, 64),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          "Submit Penilaian",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.scoreControllers.values.forEach((controller) {
      controller.dispose();
    });
    super.dispose();
  }
}
