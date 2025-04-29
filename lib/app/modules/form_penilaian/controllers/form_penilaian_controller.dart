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

  final studentList = <Student>[].obs;
  final swimStyleList = <SwimStyle>[].obs;

  final Map<int, TextEditingController> scoreControllers = {};

  var isDateSelected = false.obs;

  var indexAll = 1.obs;
  var allSelectedSwimStyle = <Rxn<SwimStyle>>[].obs;
  var allAspectList = <RxList<AssessmentAspect>>[].obs;

  @override
  void onInit() {
    super.onInit();
    allSelectedSwimStyle.add(Rxn<SwimStyle>()); // DO NOT DELETE THIS
    // fetchSwimStyle();
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

  Future<void> fetchSwimStyle(int id) async {
    await wrapLoading(isLoading, () async {
      final response = await apiService.getStyleSwim(id);

      if (response.statusCode == 200) {
        swimStyleList.value = SwimStyleResponse.fromJson(response.body).data;
      } else {
        logError("Fetch swim styles", response.statusCode);
      }
    });
  }

  Future<void> fetchAspectSwimStyle(int index) async {
    final swimStyle = allSelectedSwimStyle[index].value;
    if (swimStyle == null) return;

    await wrapLoading(isLoading, () async {
      final response = await apiService.getStyleSwimAspect(swimStyle.id);

      if (response.statusCode == 200) {
        allAspectList.add(
          AssessmentAspectResponse.fromJson(response.body).data.obs,
        );
      } else {
        logError("Fetch aspects", response.statusCode);
      }
    });
  }

  Future<void> submitAssessment() async {
    final student = selectedStudent.value;
    final schedule = selectedSchedule.value;

    if (student == null || schedule == null || swimStylesWithAspects.isEmpty) {
      return;
    }

    final body = {
      "student_id": student.id,
      "assessment_date": dateController.text,
      "schedule_id": schedule.id,
      "package_id": schedule.packageId,
      "categories":
          swimStylesWithAspects.map((style) {
            return {
              "assessment_category_id": style.id,
              "details":
                  style.aspects.map((aspect) {
                    return {
                      "aspect_id": aspect.id,
                      "score": aspect.score,
                      "remarks": aspect.remarks ?? "",
                    };
                  }).toList(),
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

  bool isDateWithSchedule(DateTime date) {
    // Contoh logika: Periksa apakah tanggal ada di daftar jadwal
    return scheduleController.scheduleList.any(
      (schedule) =>
          schedule.date ==
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    );
  }
}
