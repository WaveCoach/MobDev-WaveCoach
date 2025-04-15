import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // Pastikan import 'dart:io' untuk File

import '../controllers/ajukan_pengembalian_controller.dart';

class AjukanPengembalianView extends GetView<AjukanPengembalianController> {
  const AjukanPengembalianView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Peminjaman'), centerTitle: true),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final detail = controller.detailPinjaman.value;

        if (detail == null) {
          return const Center(child: Text("Data tidak ditemukan."));
        }

        return Padding(
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
                    controller.selectedImage.value = image.path;
                  }
                },
                icon: const Icon(Icons.camera_alt),
                label: const Text("Upload Gambar"),
              ),
              const SizedBox(height: 16),
              Obx(() {
                final imagePath = controller.selectedImage.value;
                if (imagePath == '')
                  return const SizedBox.shrink(); // Jika tidak ada gambar yang dipilih

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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        File(imagePath),
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        );
      }),
    );
  }
}
