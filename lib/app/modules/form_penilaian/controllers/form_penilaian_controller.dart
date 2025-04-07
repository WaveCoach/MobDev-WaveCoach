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
    await _wrapLoading(() async {
      final response = await apiService.listSchedule(
        date: date,
        month: month,
        history: history,
      );

      if (response.statusCode == 200) {
        final data = ScheduleResponse.fromJson(response.body).data.schedule;
        scheduleController.scheduleList.value = data;
      } else {
        _logError("Fetch schedules", response.statusCode);
      }
    });
  }

  Future<void> fetchStudentBySchedule() async {
    final schedule = selectedSchedule.value;
    if (schedule == null) return;

    await _wrapLoading(() async {
      final response = await apiService.getStudentbySchedule(schedule.id);

      if (response.statusCode == 200) {
        studentList.value = StudentResponse.fromJson(response.body).data;
      } else {
        _logError("Fetch students", response.statusCode);
      }
    });
  }

  Future<void> fetchSwimStyle() async {
    await _wrapLoading(() async {
      final response = await apiService.getStyleSwim();

      if (response.statusCode == 200) {
        swimStyleList.value = SwimStyleResponse.fromJson(response.body).data;
      } else {
        _logError("Fetch swim styles", response.statusCode);
      }
    });
  }

  Future<void> fetchAspectSwimStyle() async {
    final swimStyle = selectedSwimStyle.value;
    if (swimStyle == null) return;

    await _wrapLoading(() async {
      final response = await apiService.getStyleSwimAspect(swimStyle.id);

      if (response.statusCode == 200) {
        aspectList.value =
            AssessmentAspectResponse.fromJson(response.body).data;
      } else {
        _logError("Fetch aspects", response.statusCode);
      }
    });
  }

  Future<void> _wrapLoading(Future<void> Function() func) async {
    try {
      isLoading.value = true;
      await func();
    } catch (e) {
      print("Unexpected error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void _logError(String context, dynamic statusCode) {
    print("Failed to $context: $statusCode");
  }

  @override
  void onClose() {
    dateController.dispose();
    packageController.dispose();
    super.onClose();
  }
}
