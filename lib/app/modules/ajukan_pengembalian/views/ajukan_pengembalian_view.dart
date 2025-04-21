import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mob_dev_wave_coach/app/core/values/app_colors.dart';
import 'dart:io'; // Pastikan import 'dart:io' untuk File

import '../controllers/ajukan_pengembalian_controller.dart';

class AjukanPengembalianView extends GetView<AjukanPengembalianController> {
  const AjukanPengembalianView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0, // Adjust spacing between back icon and title
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
                "Ajukan\nPengembalian",
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
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final detail = controller.detailPinjaman.value;

                  if (detail == null) {
                    return const Center(child: Text("Data tidak ditemukan."));
                  }

                  // Set default value for qtyReturnedController
                  controller.qtyReturnedController.text =
                      "${detail.qtyBorrow ?? 0}";

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          "Nama Coach",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextFormField(
                            controller: TextEditingController(
                              text: detail.coachName,
                            ),
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            readOnly: true,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          "Nama Master Coach",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextFormField(
                            controller: TextEditingController(
                              text: detail.mastercoachName,
                            ),
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            readOnly: true,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          "Tanggal Pinjam",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.contrastBlue,
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextFormField(
                            controller: TextEditingController(
                              text: detail.tanggalPinjam,
                            ),
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                            decoration: const InputDecoration(
                              hintText: "Tanggal Pinjam",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),

                            readOnly: true,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          "Tanggal Pengembalian",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.contrastBlue,
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextFormField(
                            controller: controller.returnedAtController,
                            decoration: InputDecoration(
                              hintText: "Pilih Tanggal",
                              hintStyle: TextStyle(color: Colors.white),
                              border: InputBorder.none,
                              suffixIcon: Icon(
                                Icons.calendar_today,
                                color: Colors.white,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 16,
                              ),
                              alignLabelWithHint: true,
                            ),
                            textAlign: TextAlign.left,
                            textAlignVertical: TextAlignVertical.center,
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
                                controller.returnedAtController.text =
                                    "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                              }
                            },
                          ),
                        ),
                      ),

                      // TextField(
                      //   controller: controller.returnedAtController,
                      //   readOnly: true,
                      //   decoration: InputDecoration(
                      //     labelText: "Tanggal Kembali",
                      //     border: const OutlineInputBorder(),
                      //     suffixIcon: IconButton(
                      //       icon: const Icon(Icons.calendar_today),
                      //       onPressed: () async {
                      //         final DateTime? pickedDate =
                      //             await showDatePicker(
                      //               context: context,
                      //               initialDate: DateTime.now(),
                      //               firstDate: DateTime(2000),
                      //               lastDate: DateTime(2100),
                      //             );
                      //         if (pickedDate != null) {
                      //           controller.returnedAtController.text =
                      //               "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                      //         }
                      //       },
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          "Barang yang dipinjam",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: AppColors.contrastBlue,
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: TextFormField(
                                  controller: TextEditingController(
                                    text: detail.inventoryName,
                                  ),
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                  decoration: const InputDecoration(
                                    hintText: "Nama Barang",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                  ),

                                  readOnly: true,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: AppColors.contrastBlue,
                                border: Border.all(color: Colors.white),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: TextFormField(
                                  controller: controller.qtyReturnedController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter
                                        .digitsOnly, // Hanya angka
                                    TextInputFormatter.withFunction((
                                      oldValue,
                                      newValue,
                                    ) {
                                      if (newValue.text.isEmpty)
                                        return newValue;
                                      final int? value = int.tryParse(
                                        newValue.text,
                                      );
                                      if (value == null ||
                                          value < 1 ||
                                          value > (detail.qtyBorrow ?? 0)) {
                                        return oldValue; // Batalkan perubahan jika di luar batas
                                      }
                                      return newValue;
                                    }),
                                  ],
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "${detail.qtyBorrow}",
                                    hintStyle: TextStyle(
                                      color: Colors.white.withOpacity(0.5),
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (value) {
                                    final int? qty = int.tryParse(value);
                                    if (qty != null &&
                                        qty > (detail.qtyBorrow ?? 0)) {
                                      controller.qtyReturnedController.text =
                                          "${detail.qtyBorrow}";
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Obx(() {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Terdapat barang rusak?",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            Switch(
                              value: controller.isDamaged.value,
                              onChanged: (bool value) {
                                final int missingValue =
                                    int.tryParse(
                                      controller.missingController.text,
                                    ) ??
                                    0;
                                if (value &&
                                    missingValue == (detail.qtyBorrow ?? 0)) {
                                  // Jika barang hilang mencapai maksimum, switch rusak tidak dapat diaktifkan
                                  return;
                                }
                                controller.isDamaged.value = value;
                              },
                              activeColor: AppColors.deepOceanBlue,
                              inactiveThumbColor: Colors.grey,
                              inactiveTrackColor: Colors.grey.withOpacity(0.5),
                            ),
                          ],
                        );
                      }),
                      const SizedBox(height: 8),
                      Obx(() {
                        if (!controller.isDamaged.value)
                          return const SizedBox();
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: TextFormField(
                              controller: controller.damagedController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                TextInputFormatter.withFunction((
                                  oldValue,
                                  newValue,
                                ) {
                                  if (newValue.text.isEmpty) return newValue;
                                  final int? damagedValue = int.tryParse(
                                    newValue.text,
                                  );
                                  final int missingValue =
                                      int.tryParse(
                                        controller.missingController.text,
                                      ) ??
                                      0;
                                  final int maxDamaged =
                                      (detail.qtyBorrow ?? 0) - missingValue;

                                  if (damagedValue == null ||
                                      damagedValue < 0 ||
                                      damagedValue > maxDamaged) {
                                    return oldValue; // Batalkan perubahan jika di luar batas
                                  }

                                  return newValue;
                                }),
                              ],
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                hintText: "Jumlah barang rusak",
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                              ),
                              onChanged: (value) {
                                controller
                                    .update(); // Perbarui UI jika ada perubahan
                              },
                            ),
                          ),
                        );
                      }),
                      Obx(() {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Terdapat barang hilang?",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            Switch(
                              value: controller.isMissing.value,
                              onChanged: (bool value) {
                                final int damagedValue =
                                    int.tryParse(
                                      controller.damagedController.text,
                                    ) ??
                                    0;
                                final int maxItems = detail.qtyBorrow ?? 0;

                                if (value && damagedValue == maxItems) {
                                  // Jika jumlah barang rusak sudah mencapai maksimum, switch tidak dapat diaktifkan
                                  return;
                                }
                                controller.isMissing.value = value;
                              },
                              activeColor: AppColors.deepOceanBlue,
                              inactiveThumbColor: Colors.grey,
                              inactiveTrackColor: Colors.grey.withOpacity(0.5),
                            ),
                          ],
                        );
                      }),
                      const SizedBox(height: 8),
                      Obx(() {
                        if (!controller.isMissing.value)
                          return const SizedBox();
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: TextFormField(
                              controller: controller.missingController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                TextInputFormatter.withFunction((
                                  oldValue,
                                  newValue,
                                ) {
                                  if (newValue.text.isEmpty) return newValue;
                                  final int? missingValue = int.tryParse(
                                    newValue.text,
                                  );
                                  final int damagedValue =
                                      int.tryParse(
                                        controller.damagedController.text,
                                      ) ??
                                      0;
                                  final int maxMissing =
                                      (detail.qtyBorrow ?? 0) - damagedValue;

                                  if (missingValue == null ||
                                      missingValue < 0 ||
                                      missingValue > maxMissing) {
                                    return oldValue; // Batalkan perubahan jika di luar batas
                                  }

                                  return newValue;
                                }),
                              ],
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                hintText: "Jumlah barang hilang",
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                              ),
                              onChanged: (value) {
                                controller
                                    .update(); // Perbarui UI jika ada perubahan
                              },
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 16),

                      Center(
                        child: SizedBox(
                          width: 225, // Ganti dengan lebar yang diinginkan
                          height: 60, // Ganti dengan tinggi yang diinginkan
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              final ImagePicker picker = ImagePicker();
                              final XFile? image = await showDialog<XFile?>(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Pilih Sumber Gambar'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ListTile(
                                          leading: const Icon(Icons.camera_alt),
                                          title: const Text('Kamera'),
                                          onTap: () async {
                                            final XFile? pickedImage =
                                                await picker.pickImage(
                                                  source: ImageSource.camera,
                                                );
                                            Navigator.pop(context, pickedImage);
                                          },
                                        ),
                                        ListTile(
                                          leading: const Icon(
                                            Icons.photo_library,
                                          ),
                                          title: const Text('Galeri'),
                                          onTap: () async {
                                            final XFile? pickedImage =
                                                await picker.pickImage(
                                                  source: ImageSource.gallery,
                                                );
                                            Navigator.pop(context, pickedImage);
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );

                              if (image != null) {
                                controller.selectedImage.value = File(
                                  image.path,
                                );
                              }
                            },
                            icon: const Icon(
                              Icons.camera_alt,
                              color:
                                  Colors.white, // Ubah warna ikon menjadi putih
                            ),
                            label: Text(
                              "Upload Bukti Gambar",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.white,
                              ), // Ubah warna tulisan menjadi putih
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  AppColors.deepOceanBlue, // Warna tombol
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  12,
                                ), // Radius sudut tombol
                              ),
                            ),
                          ),
                        ),
                      ),
                      Obx(() {
                        final File? imagePath = controller.selectedImage.value;
                        if (imagePath == null) {
                          return const SizedBox.shrink();
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            Text(
                              'Preview Gambar:',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            if (imagePath != null)
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.file(
                                      imagePath,
                                      width: double.infinity,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 8,
                                    left: 8,
                                    child: GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Dialog(
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: Image.file(
                                                  imagePath,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.6),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(
                                              Icons.visibility,
                                              color: Colors.white,
                                              size: 16,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              "Lihat Gambar",
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        );
                      }),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          "Deskripsi",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.red,
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
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: TextFormField(
                            controller: controller.descController,
                            decoration: const InputDecoration(
                              hintText: "Ketik Disini",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                              alignLabelWithHint:
                                  true, // Align label with the top-left corner
                            ),
                            maxLines: 3,
                            textAlign:
                                TextAlign
                                    .start, // Align text to the top-left corner
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: ElevatedButton(
                          onPressed: () {
                            final args = Get.arguments;
                            final landingId = args['landingId'];

                            controller.submitReturnRequest(landingId);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.goldenAmber,
                            minimumSize: Size(double.infinity, 64),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            "Submit Pengajuan",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
