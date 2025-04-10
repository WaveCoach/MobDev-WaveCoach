import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mob_dev_wave_coach/app/core/services/api_service.dart';
import 'package:mob_dev_wave_coach/app/core/utils/loading_helper.dart';
import 'package:mob_dev_wave_coach/app/modules/ajukan_peminjaman/model/inventory_mastercoach_response.dart';
import 'package:mob_dev_wave_coach/app/modules/ajukan_peminjaman/model/inventory_matercoach_model.dart';
import 'package:mob_dev_wave_coach/app/modules/ajukan_peminjaman/model/mastercoach_model.dart';
import 'package:mob_dev_wave_coach/app/modules/ajukan_peminjaman/model/mastercoach_response.dart';

class AjukanPeminjamanController extends GetxController {
  final ApiService apiService = Get.find<ApiService>();
  final isLoading = false.obs;
  final name = ''.obs;

  final dateBorrowController = TextEditingController();
  final dateReturnController = TextEditingController();

  final selectedMatercoach = Rxn<MasterCoach>();
  final masterCoachList = <MasterCoach>[].obs;

  final selectedStuff = Rxn<InventoryItem>();
  final stuffList = <InventoryItem>[].obs;

  final stuffFormList =
      <Map<String, dynamic>>[
        {'selectedStuff': null, 'quantity': ''},
      ].obs;

  @override
  void onInit() {
    super.onInit();
    name.value = GetStorage().read("name") ?? "";
    fetchMasterCoach();
  }

  Future<void> fetchMasterCoach() async {
    await wrapLoading(isLoading, () async {
      final response = await apiService.getMastercoach();
      if (response.statusCode == 200) {
        masterCoachList.value =
            MasterCoachResponse.fromJson(response.body).data;
      } else {
        logError("fetch master coach", response.statusText);
      }
    });
  }

  Future<void> fetchInventory() async {
    final mastercoachId = selectedMatercoach.value?.id;
    if (mastercoachId == null) return;
    print("Selected Mastercoach ID: $mastercoachId 🎯");
    await wrapLoading(isLoading, () async {
      final response = await apiService.getInventoryManagementMastercoach(
        mastercoachId,
      );
      if (response.statusCode == 200) {
        stuffList.value = InventoryResponse.fromJson(response.body).data;
        print(stuffList);
      } else {
        logError("fetch inventory", response.statusText);
      }
    });
  }

  void onClose() {
    dateBorrowController.dispose();
    dateReturnController.dispose();
    super.onClose();
  }
}
