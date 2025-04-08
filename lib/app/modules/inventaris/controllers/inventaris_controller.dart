import 'package:get/get.dart';
import 'package:mob_dev_wave_coach/app/modules/inventaris/model/borrowed_item_model.dart';
import 'package:mob_dev_wave_coach/app/modules/inventaris/model/history_inventory_model.dart';
import 'package:mob_dev_wave_coach/app/modules/inventaris/model/stock_list_model.dart';
import 'package:mob_dev_wave_coach/app/core/utils/loading_helper.dart'; // 👈 dipanggil di sini

import '../../../core/services/api_service.dart';
import '../model/borrowed_item_response.dart';
import '../model/history_inventory_response.dart';
import '../model/stock_list_response.dart';

class InventarisController extends GetxController {
  final apiService = Get.find<ApiService>();

  final isLoading = false.obs;
  final stockList = <StockListModel>[].obs;
  final borrowedList = <BorrowedItem>[].obs;
  final historyList = <HistoryData>[].obs;

  String? dropdownValue;

  @override
  void onInit() {
    super.onInit();
    fetchInventaris('Barang');
  }

  Future<void> fetchInventaris(String category) async {
    await wrapLoading(isLoading, () async {
      final response = switch (category) {
        'Stock Inventaris' => await apiService.listStock(),
        'History Pengajuan' => await apiService.historyPeminjamanInventaris(),
        'Barang' => await apiService.borrowedItem(),
        _ => null,
      };

      if (response == null) {
        Get.snackbar("Error", "Kategori tidak dikenali");
        return;
      }

      if (response.statusCode == 200) {
        switch (category) {
          case 'Stock Inventaris':
            stockList.value = StockListResponse.fromJson(response.body).data;
            break;
          case 'History Pengajuan':
            historyList.value =
                HistoryInventoryResponse.fromJson(response.body).data;
            break;
          case 'Barang':
            borrowedList.value =
                BorrowedItemResponse.fromJson(response.body).data;
            break;
        }
      } else {
        logError("fetch $category", response.statusCode);
        Get.snackbar("Error", "Unexpected response format");
      }
    });
  }
}
