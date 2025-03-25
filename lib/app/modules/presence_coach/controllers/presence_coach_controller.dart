import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mob_dev_wave_coach/app/core/services/api_service.dart';

class PresenceCoachController extends GetxController {
  final ApiService apiService = ApiService();
  final ImagePicker picker = ImagePicker();

  RxBool isSubmitting = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Retrieve scheduleId from Get.arguments
    int scheduleId = Get.arguments['scheduleId'];
    print('📅 Schedule ID: $scheduleId');
  }

  Future<void> submitPresence({
    required String attendanceStatus,
    required int scheduleId,
    String? remarks,
    XFile? proof,
  }) async {
    isSubmitting.value = true;
    Map<String, dynamic> body = {"schedule_id": scheduleId};
    if (attendanceStatus == "Hadir" && proof != null) {
      body["attendance_status"] = "Hadir";
      body["proof"] = proof.path;
    } else if (attendanceStatus == "Tidak Hadir" && remarks != null) {
      body["remarks"] = remarks;
    }

    final response = await apiService.absensiCoach(body);
    isSubmitting.value = false;

    if (response.statusCode == 200) {
      Get.snackbar("Success", "Presensi berhasil dikirim");
    } else {
      Get.snackbar("Error", "Gagal mengirim presensi");
    }
  }
}
