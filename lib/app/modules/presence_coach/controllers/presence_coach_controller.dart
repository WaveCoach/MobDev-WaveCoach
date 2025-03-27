import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mob_dev_wave_coach/app/core/services/api_service.dart';

class PresenceCoachController extends GetxController {
  final ApiService apiService = ApiService();
  final ImagePicker picker = ImagePicker();
  RxString capturedImagePath = ''.obs;
  var arguments = Get.arguments;

  RxBool isSubmitting = false.obs;
  RxBool showBuktiKehadiranButton = false.obs;

  @override
  void onInit() {
    super.onInit();
    debugPrint("ARGUMENTS: $arguments");
    // capturedImagePath = Get.arguments?['capturedImage'];
    // print("📸 Captured Image Path: $capturedImagePath");
    int scheduleId = Get.arguments?['scheduleId'];
  }

  Future<void> submitPresence({
    required String attendanceStatus,
    required int scheduleId,
    String? remarks,
    XFile? proof,
    String? proofBase64,
  }) async {
    isSubmitting.value = true;
    Map<String, dynamic> body = {"schedule_id": scheduleId};
    if (attendanceStatus == "Hadir") {
      body["attendance_status"] = "Hadir";
      body["proof"] = proofBase64;
    } else if (attendanceStatus == "Tidak Hadir" && remarks != null) {
      body["attendance_status"] = "Tidak Hadir";
      body["remarks"] = remarks;
    }

    final response = await apiService.absensiCoach(body);
    isSubmitting.value = false;

    print(body.toString());

    if (response.statusCode == 201) {
      Get.snackbar("Success", "Presensi berhasil dikirim");
      Get.offAndToNamed('/schedule-detail', arguments: {'id': scheduleId});
    } else {
      print("Error: Gagal mengirim presensi: ${response.body}");
    }
  }
}
