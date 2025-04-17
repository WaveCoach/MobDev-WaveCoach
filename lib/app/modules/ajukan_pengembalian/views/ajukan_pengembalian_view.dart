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
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final detail = controller.detailPinjaman.value;

        if (detail == null) {
          return const Center(child: Text("Data tidak ditemukan."));
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nama Coach: ${detail.coachName}",
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 8),
                Text(
                  "Nama Mastercoach: ${detail.mastercoachName}",
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 8),
                Text(
                  "Tanggal Pinjam: ${detail.tanggalPinjam}",
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 8),
                Text(
                  "Nama Inventaris: ${detail.inventoryName}",
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  "Jumlah Inventaris: ${detail.qtyBorrow}",
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
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
                                  final XFile? pickedImage = await picker
                                      .pickImage(source: ImageSource.camera);
                                  Navigator.pop(context, pickedImage);
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.photo_library),
                                title: const Text('Galeri'),
                                onTap: () async {
                                  final XFile? pickedImage = await picker
                                      .pickImage(source: ImageSource.gallery);
                                  Navigator.pop(context, pickedImage);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );

                    if (image != null) {
                      controller.selectedImage.value = File(image.path);
                    }
                  },
                  icon: const Icon(Icons.camera_alt),
                  label: const Text("Upload Gambar"),
                ),
                const SizedBox(height: 16),
                Obx(() {
                  final File? imagePath = controller.selectedImage.value;
                  if (imagePath == null) {
                    return const SizedBox.shrink();
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Preview Gambar:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (imagePath != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            imagePath,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                    ],
                  );
                }),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      "Terdapat barang rusak?",
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(width: 8),
                    Obx(() {
                      return Checkbox(
                        value: controller.isDamaged.value,
                        onChanged: (bool? value) {
                          if (value != null) {
                            controller.isDamaged.value = value;
                          }
                        },
                      );
                    }),
                  ],
                ),
                const SizedBox(height: 8),
                Obx(() {
                  if (!controller.isDamaged.value) return const SizedBox();
                  return TextField(
                    controller: controller.damagedController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Jumlah barang rusak",
                      border: OutlineInputBorder(),
                    ),
                  );
                }),
                Row(
                  children: [
                    Text(
                      "Terdapat barang hilang?",
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(width: 8),
                    Obx(() {
                      return Checkbox(
                        value: controller.isMissing.value,
                        onChanged: (bool? value) {
                          if (value != null) {
                            controller.isMissing.value = value;
                          }
                        },
                      );
                    }),
                  ],
                ),
                const SizedBox(height: 8),
                Obx(() {
                  if (!controller.isMissing.value) return const SizedBox();
                  return TextField(
                    controller:
                        controller
                            .missingController, // Use missingController here
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Jumlah barang hilang", // Correct label
                      border: OutlineInputBorder(),
                    ),
                  );
                }),
                const SizedBox(height: 16),
                TextField(
                  controller: controller.qtyReturnedController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Jumlah Pengembalian",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: controller.returnedAtController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "Tanggal Kembali",
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (pickedDate != null) {
                          controller.returnedAtController.text =
                              "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    final args = Get.arguments;
                    final landingId = args['landingId'];

                    controller.submitReturnRequest(landingId);
                  },
                  child: const Text("Ajukan Pengembalian"),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
