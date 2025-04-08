import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../core/services/api_service.dart';
import '../../schedule/controllers/schedule_controller.dart';
import '../../schedule/model/schedule_response.dart';
import '../model/aspect_assessment_model.dart';
import '../model/aspect_assessment_response.dart';
import '../model/student_model.dart';
import '../model/student_response.dart';
import '../model/swim_style_model.dart';
import '../model/swim_style_response.dart';
import '../../../core/utils/loading_helper.dart';

class FormPenilaianController extends GetxController {
  final scheduleController = Get.find<ScheduleController>();
  final apiService = Get.find<ApiService>();

  final isLoading = false.obs;

  final dateController = TextEditingController();
  final packageController = TextEditingController();

  final selectedSchedule = Rxn<Schedule>();
  final selectedStudent = Rxn<Student>();
  final selectedSwimStyle = Rxn<SwimStyle>();

  final studentList = <Student>[].obs;
  final swimStyleList = <SwimStyle>[].obs;
  final aspectList = <AssessmentAspect>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchSwimStyle();
  }

  Future<void> fetchSchedulesByDate({
    required String date,
    String? month,
    bool? history,
  }) async {
    await wrapLoading(isLoading, () async {
      final response = await apiService.listSchedule(
        date: date,
        month: month,
        history: history,
      );

      if (response.statusCode == 200) {
        final data = ScheduleResponse.fromJson(response.body).data.schedule;
        scheduleController.scheduleList.value = data;
      } else {
        logError("Fetch schedules", response.statusCode);
      }
    });
  }

  Future<void> fetchStudentBySchedule() async {
    final schedule = selectedSchedule.value;
    if (schedule == null) return;

    await wrapLoading(isLoading, () async {
      final response = await apiService.getStudentbySchedule(schedule.id);

      if (response.statusCode == 200) {
        studentList.value = StudentResponse.fromJson(response.body).data;
      } else {
        logError("Fetch students", response.statusCode);
      }
    });
  }

  Future<void> fetchSwimStyle() async {
    await wrapLoading(isLoading, () async {
      final response = await apiService.getStyleSwim();

      if (response.statusCode == 200) {
        swimStyleList.value = SwimStyleResponse.fromJson(response.body).data;
      } else {
        logError("Fetch swim styles", response.statusCode);
      }
    });
  }

  Future<void> fetchAspectSwimStyle() async {
    final swimStyle = selectedSwimStyle.value;
    if (swimStyle == null) return;

    await wrapLoading(isLoading, () async {
      final response = await apiService.getStyleSwimAspect(swimStyle.id);

      if (response.statusCode == 200) {
        aspectList.value =
            AssessmentAspectResponse.fromJson(response.body).data;
      } else {
        logError("Fetch aspects", response.statusCode);
      }
    });
  }

  Future<void> submitAssessment() async {
    final student = selectedStudent.value;
    final swimStyle = selectedSwimStyle.value;
    final schedule = selectedSchedule.value;

    if (student == null || swimStyle == null || schedule == null) {
      return;
    }

    final body = {
      "student_id": student.id,
      "assessment_date": dateController.text,
      "package_id": schedule.packageId,
      "assessment_category_id": swimStyle.id,
      "details":
          aspectList.map((aspect) {
            return {
              "aspect_id": aspect.id,
              "score": aspect.score,
              "remarks": aspect.remarks ?? "",
            };
          }).toList(),
    };

    await wrapLoading(isLoading, () async {
      final response = await apiService.postAssessment(body);

      if (response.statusCode == 200) {
        Get.snackbar(
          "Success",
          "Assessment submitted successfully",
          snackPosition: SnackPosition.TOP,
        );
        Get.offAllNamed('/history-penilaian');
      } else {
        logError(
          "Submit assessment",
          "${response.statusCode}: ${response.body}",
        );
        Get.snackbar(
          "Error",
          "Failed to submit assessment: ${response.body}",
          snackPosition: SnackPosition.TOP,
        );
      }
    });
  }

  @override
  void onClose() {
    dateController.dispose();
    packageController.dispose();
    super.onClose();
  }
}
