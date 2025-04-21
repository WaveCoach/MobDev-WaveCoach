import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mob_dev_wave_coach/app/core/values/app_colors.dart';

class PenilaianView extends StatefulWidget {
  const PenilaianView({super.key});

  @override
  State<PenilaianView> createState() => _PenilaianViewState();
}

class _PenilaianViewState extends State<PenilaianView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.skyBlue,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 80),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Penilaian',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  fontSize: 40,
                  color: Colors.black,
                  letterSpacing: -0.3,
                ),
              ),
            ),
            SizedBox(height: 30),
            LayoutBuilder(
              builder: (context, constraints) {
                // Menentukan ukuran gambar secara dinamis berdasarkan lebar layar
                double imageSize = constraints.maxWidth * 0.7; // 60% dari lebar layar
                return SvgPicture.asset(
                  'assets/images/GroupPeople.svg',
                  width: imageSize,
                  height: imageSize,
                );
              },
            ),
            Spacer(), // Menambahkan spacer untuk mendorong tombol ke bawah
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFDC373),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
              ),
              onPressed: () {
                // Add your onPressed logic here
                Get.toNamed('/form-penilaian');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Form",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 26,
                          color: Colors.black,
                          letterSpacing: -0.6,
                          height: 1,
                        ),
                      ),
                      Text(
                        "Penilaian",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 32,
                          color: Colors.black,
                          letterSpacing: -0.6,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                  SvgPicture.asset(
                    'assets/images/FormPenilaianIcon.svg',
                    width: 50,
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFDC373),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
              ),
              onPressed: () {
                // Add your onPressed logic here
                Get.toNamed('/history-penilaian');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "History",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 26,
                          color: Colors.black,
                          letterSpacing: -0.6,
                          height: 1,
                        ),
                      ),
                      Text(
                        "Penilaian",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 32,
                          color: Colors.black,
                          letterSpacing: -0.6,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                  SvgPicture.asset(
                    'assets/images/HistoryPenilaianIcon.svg',
                    width: 50,
                  ),
                ],
              ),
            ),
            SizedBox(height: 120), // Memberikan jarak 120 dari bawah layar
          ],
        ),
      ),
    );
  }
}
