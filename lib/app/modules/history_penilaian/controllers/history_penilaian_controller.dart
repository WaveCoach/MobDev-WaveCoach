import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mob_dev_wave_coach/app/core/services/api_service.dart';
import 'package:mob_dev_wave_coach/app/modules/history_penilaian/model/history_penilaian_model.dart';
import 'package:mob_dev_wave_coach/app/core/utils/loading_helper.dart';
import 'package:mob_dev_wave_coach/app/modules/history_penilaian/model/history_penilaian_response.dart';

class HistoryPenilaianController extends GetxController {
  final ApiService apiService = Get.find<ApiService>();
  final isLoading = false.obs;
  final historyPenilaianList = <AssessmentHistory>[].obs;
  final searchQuery = ''.obs;
  final searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchHistoryPenilaian();
  }

  Future<void> fetchHistoryPenilaian({String? query}) async {
    await wrapLoading(isLoading, () async {
      final response = await apiService.getHistoryAssessment(search: query);

      if (response.statusCode == 200 && response.body != null) {
        final data = AssessmentHistoryResponse.fromJson(response.body).data;
        historyPenilaianList.value = data;
      } else {
        logError("fetch history penilaian", response.statusText);
        Get.snackbar("Error", "Failed to load history penilaian");
      }
    });
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
