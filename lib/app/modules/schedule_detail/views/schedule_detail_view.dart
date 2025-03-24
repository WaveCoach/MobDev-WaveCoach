import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mob_dev_wave_coach/app/core/values/app_colors.dart';
import '../controllers/schedule_detail_controller.dart';

class ScheduleDetailView extends GetView<ScheduleDetailController> {
  const ScheduleDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        width: double.infinity,
        height: 420,
        decoration: BoxDecoration(
          color: AppColors.deepOceanBlue,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '17',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 200,
                fontWeight: FontWeightStyles.bold,
              ),
            ),
            Text(
              'Januari 2024',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 50,
                fontWeight: FontWeightStyles.bold,
              ),
            ),
          ],
        ),
      );
    }

    Widget location() {
      return Container(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                margin: EdgeInsets.only(right: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.access_time_filled,
                            color: AppColors.deepOceanBlue,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Pelaksanaan',
                            style: GoogleFonts.poppins(
                              color: AppColors.deepOceanBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '12.00 - 12.50',
                            style: GoogleFonts.poppins(
                              color: AppColors.deepOceanBlue,
                              fontSize: 24,
                              fontWeight: FontWeightStyles.medium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.deepOceanBlue,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(8.0),
                margin: EdgeInsets.only(left: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment:
                      CrossAxisAlignment.center, // Pusatkan vertikal
                  children: [
                    Expanded(
                      child: Text(
                        'Lokasi Latihannnnnnnn yang sangat panjang hingga perlu turun ke bawah',
                        style: GoogleFonts.poppins(color: Colors.white),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      ),
                    ),
                    Icon(Icons.location_on, color: Colors.white, size: 50),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(body: Column(children: [header(), location()]));
  }
}
