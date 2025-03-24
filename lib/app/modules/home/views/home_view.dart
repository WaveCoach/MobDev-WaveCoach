import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mob_dev_wave_coach/app/core/values/app_colors.dart';
import 'package:mob_dev_wave_coach/app/modules/inventaris/views/inventaris_view.dart';
import 'package:mob_dev_wave_coach/app/modules/penilaian/views/penilaian_view.dart';
import 'package:mob_dev_wave_coach/app/modules/profile/views/profile_view.dart';
import 'package:mob_dev_wave_coach/app/modules/schedule/views/schedule_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final HomeController controller = Get.put(HomeController());

  final List<Widget> pages = [
    ScheduleView(),
    InventarisView(),
    PenilaianView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    Widget navBar() {
      return Container(
        height: 80,
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        decoration: BoxDecoration(
          color: AppColors.deepOceanBlue,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(20),
              spreadRadius: 10,
              blurRadius: 20,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(4, (index) {
            String iconPath;
            switch (index) {
              case 0:
                iconPath = 'assets/icons/NavBarJadwal.svg';
                break;
              case 1:
                iconPath = 'assets/icons/NavBarInventaris.svg';
                break;
              case 2:
                iconPath = 'assets/icons/NavBarPenilaian.svg';
                break;
              case 3:
                iconPath = 'assets/icons/NavBarProfil.svg';
                break;
              default:
                iconPath = 'assets/icons/default.svg';
            }
            return GestureDetector(
              onTap: () {
                controller.currentIndex.value = index;
              },
              child: Container(
                width: 65,
                height: 65,
                decoration: BoxDecoration(
                  color: controller.currentIndex.value == index
                      ? Colors.white
                      : AppColors.deepOceanBlue,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  margin: const EdgeInsets.all(15),
                  child: SvgPicture.asset(
                    iconPath,
                    color: controller.currentIndex.value == index
                        ? AppColors.deepOceanBlue
                        : Colors.white,
                  ),
                ),
              ),
            );
          }),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          Obx(
            () => IndexedStack(
              index: controller.currentIndex.value,
              children: pages,
            ),
          ),
          Obx(() => Align(alignment: Alignment.bottomCenter, child: navBar())),
        ],
      ),
    );
  }
}
