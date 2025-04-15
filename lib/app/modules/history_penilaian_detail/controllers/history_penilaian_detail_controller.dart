import 'package:get/get.dart';
import 'package:mob_dev_wave_coach/app/core/services/api_service.dart';
import 'package:mob_dev_wave_coach/app/core/utils/loading_helper.dart';
import 'package:mob_dev_wave_coach/app/modules/history_penilaian_detail/model/history_penilaian_detail_response.dart';

class HistoryPenilaianDetailController extends GetxController {
  final ApiService apiService = Get.find<ApiService>();
  final isLoading = false.obs;
  final historyDetailResponse = Rxn<HistoryDetailResponse>();

  @override
  void onInit() {
    super.onInit();
    final id = Get.arguments;
    fetchHistoryDetail(id);
  }

  Future<void> fetchHistoryDetail(int id) async {
    await wrapLoading(isLoading, () async {
      final response = await apiService.getDetailHistoryAssessment(id);

      if (response.statusCode == 200 && response.body != null) {
        historyDetailResponse.value = HistoryDetailResponse.fromJson(
          response.body,
        );
      } else {
        logError("fetch history detail", response.statusText);
        Get.snackbar("Error", "Failed to load history detail");
      }
    });
  }
}
