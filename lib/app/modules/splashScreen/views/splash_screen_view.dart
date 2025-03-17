import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mob_dev_wave_coach/app/core/values/app_colors.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deepOceanBlue,
      body: Center(
        child: Container(
          width: 130,
          height: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/LatinWaveCoach.png'),
            ),
          ),
        ),
      ),
    );
  }
}
