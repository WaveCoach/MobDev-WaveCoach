import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mob_dev_wave_coach/app/core/services/api_service.dart';
import 'package:mob_dev_wave_coach/app/modules/form_penilaian/model/aspect_assessment_response.dart';
import 'package:mob_dev_wave_coach/app/modules/form_penilaian/model/student_model.dart';
import 'package:mob_dev_wave_coach/app/modules/form_penilaian/model/swim_style_model.dart';
import 'package:mob_dev_wave_coach/app/modules/form_penilaian/model/swim_style_response.dart';
import 'package:mob_dev_wave_coach/app/modules/schedule/controllers/schedule_controller.dart';
import 'package:mob_dev_wave_coach/app/modules/schedule/model/schedule_response.dart';
import 'package:mob_dev_wave_coach/app/modules/form_penilaian/model/student_response.dart';

class FormPenilaianController extends GetxController {
  final ScheduleController scheduleController = Get.find<ScheduleController>();
  final TextEditingController dateController = TextEditingController();
  var isLoading = false.obs;
  var selectedSchedule = Rxn<Schedule>();
  final ApiService apiService = Get.find<ApiService>();
  final RxList<Student> studentList = <Student>[].obs;
  var selectedStudent = Rxn<Student>();
  final RxList<SwimStyle> swimStyleList = <SwimStyle>[].obs;
  var selectedSwimStyle = Rxn<SwimStyle>();

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
    try {
      isLoading.value = true;
      final response = await apiService.listSchedule(
        month: month,
        history: history,
        date: date,
      );

      if (response.statusCode == 200) {
        final decoded = response.body;
        final scheduleResponse = ScheduleResponse.fromJson(decoded);
        final scheduleList = scheduleResponse.data.schedule;

        scheduleController.scheduleList.value = scheduleList;
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching schedules: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchStudentBySchedule() async {
    final schedule = selectedSchedule.value;
    if (schedule == null) {
      print("No schedule selected.");
      return;
    }

    try {
      isLoading.value = true;
      final response = await apiService.getStudentbySchedule(schedule.id);

      if (response.statusCode == 200) {
        final decoded = response.body;
        final studentResponse = StudentResponse.fromJson(decoded);

        studentList.value = studentResponse.data;
      } else {
        print("Failed to fetch students: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching students: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchSwimStyle() async {
    try {
      isLoading.value = true;
      final response = await apiService.getStyleSwim();

      if (response.statusCode == 200) {
        final decoded = response.body;
        print("Response JSON: $decoded");
        final swimStyleResponse = SwimStyleResponse.fromJson(decoded);

        swimStyleList.value = swimStyleResponse.data;
      } else {
        print("Failed to fetch swim styles: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching swim styles: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchAspectSwimStyle() async {
    final swimStyle = selectedSwimStyle.value;
    if (swimStyle == null) {
      print("No swim style selected.");
      return;
    }

    try {
      isLoading.value = true;
      final response = await apiService.getStyleSwimAspect(swimStyle.id);

      if (response.statusCode == 200) {
        final decoded = response.body;
        print("Response JSON: $decoded");
        final aspectResponse = AssessmentAspectResponse.fromJson(decoded);
      } else {
        print("Failed to fetch swim styles: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching swim styles: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    dateController.dispose();
    super.onClose();
  }
}
