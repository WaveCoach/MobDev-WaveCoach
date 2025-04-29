import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mob_dev_wave_coach/app/core/values/app_colors.dart';
import 'package:mob_dev_wave_coach/app/modules/form_penilaian/model/student_model.dart';
import 'package:mob_dev_wave_coach/app/modules/form_penilaian/model/swim_style_model.dart';
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
            final scheduleId = Get.arguments?['scheduleId'];
            if (scheduleId != null) {
              Get.offNamed(
                '/schedule-detail',
                arguments: {'scheduleId': scheduleId},
              );
            } else {
              Get.offNamed('/home', arguments: 2);
            }
            scheduleController
                .refreshScheduleList(); // Memanggil fungsi refresh
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
                  height: 1.2,
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
                        Obx(
                          () => ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.indexAll.value,
                            itemBuilder:
                                (context, index) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildSwimStyleDropdown(index),
                                    const SizedBox(height: 16),
                                    _buildAspectAssessment(index),
                                    const SizedBox(height: 4),
                                  ],
                                ),
                          ),
                        ),
                        Center(
                          child: Obx(() {
                            // Periksa apakah setidaknya satu gaya renang telah dipilih
                            final anySwimStyleSelected = controller.allSelectedSwimStyle.any((swimStyle) => swimStyle.value != null);

                            return Visibility(
                              visible: anySwimStyleSelected, // Tampilkan tombol jika setidaknya satu gaya renang dipilih
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  setState(() {
                                    controller.indexAll++;
                                    controller.allSelectedSwimStyle.add(Rxn<SwimStyle>());
                                  });
                                },
                                icon: const Icon(Icons.add, color: Colors.white),
                                label: Text(
                                  "Tambah Penilaian",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.deepOceanBlue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                        SizedBox(height: 25),
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
            // Jalankan refresh schedule list terlebih dahulu
            await scheduleController.refreshScheduleList();

            // Cari tanggal awal yang valid
            DateTime initialDate = DateTime.now();
            if (!controller.isDateWithSchedule(initialDate)) {
              // Jika tanggal saat ini tidak valid, cari tanggal valid berikutnya
              initialDate = await _findNextValidDate();
            }

            final pickedDate = await showDatePicker(
              context: context,
              initialDate: initialDate,
              firstDate: DateTime.now().subtract(
                const Duration(days: 30),
              ), // Mulai dari 1 bulan sebelumnya
              lastDate: scheduleController.scheduleList.isNotEmpty
                  ? (scheduleController.scheduleList.last.date is DateTime
                      ? scheduleController.scheduleList.last.date as DateTime
                      : DateTime.tryParse(
                            scheduleController.scheduleList.last.date.toString(),
                          ) ??
                          DateTime(2101)) // Safely parse or fallback
                  : DateTime(2101), // Default jika tidak ada jadwal
              selectableDayPredicate: (DateTime date) {
                // Periksa apakah tanggal memiliki jadwal latihan dengan assessment
                return scheduleController.scheduleList.any((schedule) {
                  final scheduleDate = schedule.date is DateTime
                      ? schedule.date as DateTime
                      : DateTime.tryParse(schedule.date.toString());
                  return scheduleDate != null &&
                      scheduleDate.year == date.year &&
                      scheduleDate.month == date.month &&
                      scheduleDate.day == date.day &&
                      schedule.isAssessed == 1; // Hanya jadwal dengan assessment
                });
              },
              builder: (BuildContext context, Widget? child) {
                return Theme(
                  data: ThemeData.light().copyWith(
                    primaryColor: AppColors.deepOceanBlue, // Warna utama
                    hintColor: AppColors.goldenAmber, // Warna aksen
                    colorScheme: ColorScheme.light(
                      primary: AppColors.deepOceanBlue, // Warna header
                      onPrimary: Colors.white, // Warna teks header
                      surface: Colors.white, // Warna latar belakang
                      onSurface: Colors.black, // Warna teks
                    ),
                    dialogBackgroundColor: Colors.white, // Warna latar dialog
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        foregroundColor:
                            AppColors.deepOceanBlue, // Warna tombol
                      ),
                    ),
                  ),
                  child: child != null
                      ? Builder(
                          builder: (BuildContext context) {
                            return child;
                          },
                        )
                      : const SizedBox.shrink(),
                );
              },
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
              controller.allAspectList.clear();

              // Reset Gaya Renang
              controller.allSelectedSwimStyle.clear();
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
                    controller.allAspectList.clear();

                    controller.fetchSwimStyle(selectedSchedule?.packageId ?? 0);

                    // Reset Gaya Renang
                    controller.allSelectedSwimStyle.clear();
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
                controller.allAspectList.clear();

                // Reset Gaya Renang
                controller.allSelectedSwimStyle.clear();
              });
            },
          ),
        ),
      );
    });
  }

  Widget _buildSwimStyleDropdown(int index) {
    return Obx(() {
      // Periksa apakah siswa telah dipilih
      final isStudentSelected = controller.selectedStudent.value != null;

      if (controller.swimStyleList.isEmpty) {
        return const Center(child: Text("Tidak ada gaya renang tersedia"));
      }

      return Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                border: Border.all(color: Colors.black.withOpacity(0.2)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: DropdownButtonFormField<SwimStyle>(
                  isExpanded: true,
                  value: isStudentSelected &&
                          index < controller.allSelectedSwimStyle.length
                      ? controller.allSelectedSwimStyle[index].value
                      : null,
                  decoration: const InputDecoration(
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
                  items: isStudentSelected
                      ? controller.swimStyleList
                          .map<DropdownMenuItem<SwimStyle>>((swimStyle) {
                          return DropdownMenuItem<SwimStyle>(
                            value: swimStyle,
                            child: Text(swimStyle.name),
                          );
                        }).toList()
                      : null, // Kosongkan item jika tidak aktif
                  onChanged: isStudentSelected
                      ? (selectedSwimStyle) {
                          if (index < controller.allSelectedSwimStyle.length) {
                            controller.allSelectedSwimStyle[index].value =
                                selectedSwimStyle;
                          } else {
                            controller.allSelectedSwimStyle.add(
                              Rxn<SwimStyle>(selectedSwimStyle),
                            );
                          }
                          controller.fetchAspectSwimStyle(index);
                        }
                      : null, // Nonaktifkan onChanged jika tidak aktif
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: controller.allSelectedSwimStyle.length > 1
                ? () {
                    setState(() {
                      // Pastikan indeks valid sebelum menghapus
                      if (index < controller.allSelectedSwimStyle.length) {
                        controller.allSelectedSwimStyle.removeAt(index);
                      }
                      if (index < controller.allAspectList.length) {
                        controller.allAspectList.removeAt(index);
                      }

                      // Kurangi jumlah dropdown yang dirender
                      controller.indexAll.value--;
                    });
                  }
                : null, // Nonaktifkan tombol jika hanya tersisa satu pilihan
            icon: Icon(
              Icons.remove_circle,
              color: controller.allSelectedSwimStyle.length > 1
                  ? Colors.red
                  : Colors.grey, // Ubah warna tombol jika dinonaktifkan
            ),
          ),
        ],
      );
    });
  }

  Widget _buildAspectAssessment(int index) {
    return Obx(() {
      if (controller.allAspectList.length <= index) {
        return const SizedBox(); // just return nothing if index doesnt have anyshit
      }

      return Column(
        children:
            controller.allAspectList[index].asMap().entries.map((entry) {
              final aspectIndex = entry.key;
              final aspect = entry.value;

              // Buat controller baru jika belum ada
              controller.scoreControllers.putIfAbsent(
                aspectIndex,
                () =>
                    TextEditingController(text: aspect.score?.toString() ?? ''),
              );

              final scoreController = controller.scoreControllers[aspectIndex]!;

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

  Future<DateTime> _findNextValidDate() async {
    DateTime date = DateTime.now();
    while (!controller.isDateWithSchedule(date)) {
      date = date.add(const Duration(days: 1)); // Tambahkan 1 hari
    }
    return date;
  }

  @override
  void dispose() {
    controller.scoreControllers.values.forEach((controller) {
      controller.dispose();
    });
    super.dispose();
  }
}
