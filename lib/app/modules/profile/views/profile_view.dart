import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart'; // Ensure this is imported
import 'package:image_picker/image_picker.dart';
import 'dart:convert'; // Import for base64Encode
import 'package:mob_dev_wave_coach/app/core/values/app_colors.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final ProfileController controller = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    controller.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.skyBlue,
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  color: AppColors.deepOceanBlue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.elliptical(900, 350),
                    bottomRight: Radius.elliptical(900, 350),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final ImagePicker picker = ImagePicker();
                            final XFile? image = await showDialog<XFile?>(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Pilih Sumber Gambar'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTile(
                                        leading: Icon(Icons.camera_alt),
                                        title: Text('Kamera'),
                                        onTap: () async {
                                          final XFile? pickedImage =
                                              await picker.pickImage(
                                                source: ImageSource.camera,
                                              );
                                          Navigator.pop(context, pickedImage);
                                        },
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.photo_library),
                                        title: Text('Galeri'),
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
                              if (!mounted) return; // Ensure the widget is still mounted before proceeding

                              final bytes = await image.readAsBytes();
                              final base64Image = base64Encode(bytes);
                              final fileExtension =
                                  image.path.split('.').last.toLowerCase();

                              final mimeType =
                                  fileExtension == 'png'
                                      ? 'image/png'
                                      : fileExtension == 'jpg' ||
                                          fileExtension == 'jpeg'
                                      ? 'image/jpeg'
                                      : 'application/octet-stream';

                              if (mounted) { // Check again before updating the controller
                                controller.imageController.text =
                                    'data:$mimeType;base64,$base64Image';

                                // Update the imageUrl to trigger UI refresh
                                controller.imageUrl.value = image.path;

                                await controller.updateProfile();
                              }
                            }
                          },
                          child: Obx(
                            () => Stack(
                              children: [
                                Container(
                                  width: 135,
                                  height: 135,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: controller.imageUrl.value.startsWith('data:image')
                                          ? (controller.imageUrl.value.contains(',')
                                              ? MemoryImage(base64Decode(controller.imageUrl.value.split(',').last))
                                              : AssetImage('assets/images/default_profile.png')) // Fallback jika format tidak valid
                                          : controller.imageUrl.value.startsWith('http')
                                              ? NetworkImage(controller.imageUrl.value)
                                              : FileImage(File(controller.imageUrl.value)) as ImageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () async {
                                      final ImagePicker picker = ImagePicker();
                                      final XFile? image = await showDialog<XFile?>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Pilih Sumber Gambar'),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                ListTile(
                                                  leading: Icon(Icons.camera_alt),
                                                  title: Text('Kamera'),
                                                  onTap: () async {
                                                    final XFile? pickedImage =
                                                        await picker.pickImage(
                                                          source: ImageSource.camera,
                                                        );
                                                    Navigator.pop(context, pickedImage);
                                                  },
                                                ),
                                                ListTile(
                                                  leading: Icon(Icons.photo_library),
                                                  title: Text('Galeri'),
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
                                        if (!mounted) return; // Ensure the widget is still mounted before proceeding

                                        final bytes = await image.readAsBytes();
                                        final base64Image = base64Encode(bytes);
                                        final fileExtension =
                                            image.path.split('.').last.toLowerCase();

                                        final mimeType = fileExtension == 'png'
                                            ? 'image/png'
                                            : fileExtension == 'jpg' ||
                                                    fileExtension == 'jpeg'
                                                ? 'image/jpeg'
                                                : 'application/octet-stream';

                                        if (mounted) { // Check again before updating the controller
                                          controller.imageController.text =
                                              'data:$mimeType;base64,$base64Image';

                                          // Update the imageUrl to trigger UI refresh
                                          controller.imageUrl.value = image.path;

                                          await controller.updateProfile();
                                        }
                                      }
                                    },
                                    child: Container(
                                      width: 35,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.black,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Obx(
                          () => Text(
                            controller.name.value,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Obx(
                        () => Text(
                          controller.email.value,
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed('/change-password');
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(20),
                      backgroundColor: AppColors.pastelBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      'Ubah Kata Sandi',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Divider(
                color: AppColors.softSteelBlue,
                thickness: 1,
                indent: 40,
                endIndent: 40,
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/contact-admin');
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(20),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      'Kontak Admin',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 120,
            left: 40,
            right: 40,
            child: ElevatedButton(
              onPressed: () async {
                final shouldLogout = await showDialog<bool>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Konfirmasi Logout', 
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          )),
                      content: Text(
                        'Apakah Anda yakin ingin logout dari aplikasi?',
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
                                  backgroundColor: AppColors.deepOceanBlue, // Warna tombol
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8), // Radius tombol
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                ),
                                child: Text(
                                  'Batal',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Colors.white, // Warna teks
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => Navigator.pop(context, true),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.redPastel, // Warna tombol
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8), // Radius tombol
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                ),
                                child: Text(
                                  'Keluar',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Colors.white, // Warna teks
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

                if (shouldLogout == true) {
                  controller.logout();
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 20),
                backgroundColor: AppColors.redPastel,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
                'Logout',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Colors.white,
                  letterSpacing: -0.3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
