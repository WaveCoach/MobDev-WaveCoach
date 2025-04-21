import 'package:get/get.dart';
import 'package:mob_dev_wave_coach/app/core/services/api_service.dart';
import 'package:mob_dev_wave_coach/app/modules/contact_admin/model/contact_admin_model.dart';
import 'package:mob_dev_wave_coach/app/modules/contact_admin/model/contact_admin_response.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class ContactAdminController extends GetxController {
  var admins = <Admin>[].obs;
  var isLoading = true.obs;
  final ApiService apiService = Get.find<ApiService>();

  @override
  void onInit() {
    super.onInit();
    fetchAdmins();
  }

  void fetchAdmins() async {
    try {
      isLoading(true);
      final response = await apiService.listAdmin();
      if (response.statusCode == 200) {
        final data = response.body;
        final adminResponse = AdminResponse.fromMap(data);
        if (adminResponse.success) {
          admins.assignAll(adminResponse.admins);
        }
      }
    } catch (e) {
      print("Error fetching admins: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> refreshAdmins() async {
    isLoading.value = true;
    try {
      // Panggil API atau logika untuk memuat ulang data admin
      fetchAdmins();
    } finally {
      isLoading.value = false;
    }
  }

  void launchWhatsApp(String phone) async {
    String formattedPhone = phone.replaceAll(" ", "").replaceAll("+", "");
    final Uri whatsappUrl = Uri.parse("https://wa.me/$formattedPhone");

    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Tidak dapat membuka WhatsApp");
    }
  }
}
