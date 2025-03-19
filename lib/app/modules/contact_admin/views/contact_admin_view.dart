import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mob_dev_wave_coach/app/core/values/app_colors.dart';

import '../controllers/contact_admin_controller.dart';

class ContactAdminView extends GetView<ContactAdminController> {
  const ContactAdminView({super.key});

  @override
  Widget build(BuildContext context) {
    final ContactAdminController controller = Get.put(ContactAdminController());

    Widget header(BuildContext context) {
      return Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.deepOceanBlue,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 40,
              left: 16,
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Row(
                  children: [
                    Icon(Icons.arrow_back, color: Colors.white, size: 28),
                    SizedBox(width: 8),
                    Text(
                      "Kembali",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Text(
                  "Kontak Admin",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget adminList(BuildContext context) {
      return Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(16),
          itemCount: controller.admins.length,
          separatorBuilder: (_, __) => Divider(),
          itemBuilder: (context, index) {
            final admin = controller.admins[index];
            return ListTile(
              leading: Icon(Icons.person, color: AppColors.deepOceanBlue),
              title: Text(
                admin.name,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(
                "${admin.email}\n${admin.noTelf}",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
            );
          },
        );
      });
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [header(context), adminList(context)]),
      ),
    );
  }
}
