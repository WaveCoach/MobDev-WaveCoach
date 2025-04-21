import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mob_dev_wave_coach/app/core/services/api_service.dart';
import 'package:mob_dev_wave_coach/app/core/utils/loading_helper.dart';
import 'package:mob_dev_wave_coach/app/modules/detail_history_pengajuan/model/history_request_response.dart';
import 'package:mob_dev_wave_coach/app/modules/detail_history_pengajuan/model/history_return_response.dart';
import 'package:mob_dev_wave_coach/app/modules/home/views/home_view.dart';
import 'package:get_storage/get_storage.dart';

class DetailHistoryPengajuanController extends GetxController {
  final ApiService apiService = Get.find<ApiService>();
  final isLoading = false.obs;
  final historyRequestResponse = Rxn<HistoryInventoryRequestResponse>();
  final historyReturnResponse = Rxn<HistoryInventoryReturnResponse>();
  final feedbackController = TextEditingController();
  final selectedStatus = "".obs;
  final typeView = "".obs;
  final roleId = 0.obs;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;
    final id = args['id'];
    final type = args['type'];
    typeView.value = type;
    final box = GetStorage();
    roleId.value = int.tryParse(box.read("roleId")?.toString() ?? '0') ?? 0;

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

  Future<void> submitStatusRequest(int id, String status) async {
    isLoading.value = true;

    final body = {
      "status": status,
      "rejection_reason": feedbackController.text.trim(),
    };

    final response = await apiService.updateRequestInventory(id, body);

    if (response.statusCode == 200 && response.body != null) {
      Get.snackbar(
        "Success",
        status == "approved"
            ? "Request approved successfully"
            : "Request rejected successfully",
      );
      fetchHistoryRequest(id);
      Get.offAll(() => HomeView(), arguments: 1);
    } else {
      logError("submit request", response.statusText);
      Get.snackbar(
        "Error",
        "Failed to ${status == "approved" ? "approve" : "reject"} request",
      );
    }

    isLoading.value = false;
  }

  Future<void> submitStatusReturn(int id, String status) async {
    isLoading.value = true;

    final body = {
      "status": status,
      "rejection_reason": feedbackController.text.trim(),
    };

    final response = await apiService.updateReturnInventory(id, body);

    if (response.statusCode == 200 && response.body != null) {
      Get.snackbar(
        "Success",
        status == "approved"
            ? "Request approved successfully"
            : "Request rejected successfully",
      );
      fetchHistoryRequest(id);
      Get.offAll(() => HomeView(), arguments: 1);
    } else {
      logError("submit request", response.statusText);
      Get.snackbar(
        "Error",
        "Failed to ${status == "approved" ? "approve" : "reject"} request",
      );
    }

    isLoading.value = false;
  }
}
