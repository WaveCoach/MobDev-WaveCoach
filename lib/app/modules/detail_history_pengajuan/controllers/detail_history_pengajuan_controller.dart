import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mob_dev_wave_coach/app/core/services/api_service.dart';
import 'package:mob_dev_wave_coach/app/core/utils/loading_helper.dart';
import 'package:mob_dev_wave_coach/app/modules/detail_history_pengajuan/model/history_request_response.dart';
import 'package:mob_dev_wave_coach/app/modules/detail_history_pengajuan/model/history_return_response.dart';

class DetailHistoryPengajuanController extends GetxController {
  final ApiService apiService = Get.find<ApiService>();
  final isLoading = false.obs;
  final historyRequestResponse = Rxn<HistoryInventoryRequestResponse>();
  final historyReturnResponse = Rxn<HistoryInventoryReturnResponse>();
  final feedbackController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;
    final id = args['id'];
    final type = args['type'];
    print("ID: $id, Type: $type");
    if (type == "request") {
      fetchHistoryRequest(id);
    } else if (type == "return") {
      fetchHistoryReturn(id);
    }
  }

  Future<void> fetchHistoryRequest(int id) async {
    isLoading.value = true;
    final response = await apiService.getDetailRequest(id);

    if (response.statusCode == 200 && response.body != null) {
      historyRequestResponse.value = HistoryInventoryRequestResponse.fromJson(
        response.body,
      );
    } else {
      logError("fetch history request", response.statusText);
      Get.snackbar("Error", "Failed to load history request");
    }
    isLoading.value = false;
  }

  Future<void> fetchHistoryReturn(int id) async {
    isLoading.value = true;
    final response = await apiService.getDetailReturn(id);

    if (response.statusCode == 200 && response.body != null) {
      historyReturnResponse.value = HistoryInventoryReturnResponse.fromJson(
        response.body,
      );
      print("History Return: ${historyReturnResponse.value}");
    } else {
      logError("fetch history return", response.statusText);
      Get.snackbar("Error", "Failed to load history return");
    }
    isLoading.value = false;
  }
}
