import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_dev_wave_coach/app/modules/inventaris/views/inventaris_view.dart';
import 'package:mob_dev_wave_coach/app/modules/penilaian/views/penilaian_view.dart';
import 'package:mob_dev_wave_coach/app/modules/profile/views/profile_view.dart';
import 'package:mob_dev_wave_coach/app/modules/schedule/views/schedule_view.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
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
    return Scaffold(
      body: Obx(
        () =>
            IndexedStack(index: controller.currentIndex.value, children: pages),
      ),
      bottomNavigationBar: Obx(
        () => SalomonBottomBar(
          currentIndex: controller.currentIndex.value,
          onTap: (i) => controller.changeIndex(i),
          items: [
            SalomonBottomBarItem(
              icon: const Icon(Icons.home),
              title: const Text("Home"),
              selectedColor: Colors.purple,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.favorite_border),
              title: const Text("Likes"),
              selectedColor: Colors.pink,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.search),
              title: const Text("Search"),
              selectedColor: Colors.orange,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.person),
              title: const Text("Profile"),
              selectedColor: Colors.teal,
            ),
          ],
        ),
      ),
    );
  }
}
