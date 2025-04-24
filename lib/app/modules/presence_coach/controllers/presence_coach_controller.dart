import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:mob_dev_wave_coach/app/core/services/api_service.dart';
import 'package:mob_dev_wave_coach/app/modules/schedule_detail/controllers/schedule_detail_controller.dart';

class PresenceCoachController extends GetxController {
  final ApiService apiService = ApiService();
  final ImagePicker picker = ImagePicker();

  RxString capturedImagePath = ''.obs;
  RxBool isSubmitting = false.obs;
  RxBool showBuktiKehadiranButton = false.obs;

  var arguments = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    debugPrint("ARGUMENTS: $arguments");
  }

  Future<void> pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      capturedImagePath.value = image.path;
      showBuktiKehadiranButton.value = true;
    }
  }

  Future<String> convertImageToBase64WithHeader(String imagePath) async {
    final file = File(imagePath);
    final bytes = await file.readAsBytes();
    final mimeType = lookupMimeType(imagePath);

    if (mimeType == null) throw Exception('Mime type tidak ditemukan!');
    final base64Str = base64Encode(bytes);
    return 'data:$mimeType;base64,$base64Str';
  }

  Future<void> submitPresence({
    required String attendanceStatus,
    required int scheduleId,
    String? remarks,
  }) async {
    isSubmitting.value = true;

    String? proofBase64;
    if (capturedImagePath.value.isNotEmpty) {
      proofBase64 = await convertImageToBase64WithHeader(
        capturedImagePath.value,
      );
    }

    Map<String, dynamic> body = {
      "schedule_id": scheduleId,
      "attendance_status": attendanceStatus,
    };

    if (attendanceStatus == "Tidak Hadir" && remarks != null) {
      body["remarks"] = remarks;
    }

    if (proofBase64 != null) {
      body["proof"] = proofBase64;
    }

    final response = await apiService.absensiCoach(body);
    isSubmitting.value = false;

    if (response.statusCode == 201) {
      Get.snackbar("Success", "Presensi berhasil dikirim");
      Get.until((route) => route.settings.name == '/schedule-detail');
      Get.toNamed('/schedule-detail', arguments: {'id': scheduleId});
      final scheduleDetailController = Get.find<ScheduleDetailController>();
      scheduleDetailController.refreshSchedule();
    } else {
      print("❌ Error: ${response.body}");
      Get.snackbar("Error", "Gagal mengirim presensi");
    }
  }
}
