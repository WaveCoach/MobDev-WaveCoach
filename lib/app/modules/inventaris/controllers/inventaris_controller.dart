import 'package:get/get.dart';
import 'package:mob_dev_wave_coach/app/core/services/api_service.dart';
import 'package:mob_dev_wave_coach/app/modules/inventaris/model/borrowed_item_model.dart';
import 'package:mob_dev_wave_coach/app/modules/inventaris/model/borrowed_item_response.dart';
import 'package:mob_dev_wave_coach/app/modules/inventaris/model/history_inventory_model.dart';
import 'package:mob_dev_wave_coach/app/modules/inventaris/model/history_inventory_response.dart';
import 'package:mob_dev_wave_coach/app/modules/inventaris/model/stock_list_model.dart';
import 'package:mob_dev_wave_coach/app/modules/inventaris/model/stock_list_response.dart';

class InventarisController extends GetxController {
  var isLoading = false.obs;
  var stockList = <StockListModel>[].obs;
  var borrowedList = <BorrowedItem>[].obs;
  var historyList = <HistoryData>[].obs;
  final ApiService apiService = Get.find<ApiService>();
  String? dropdownValue;

  @override
  void onInit() {
    fetchInventaris('Barang');
    super.onInit();
  }

  void fetchInventaris(String category) async {
    try {
      isLoading(true);
      var response;

      switch (category) {
        case 'Stock Inventaris':
          //inventory yang dipegang mastercoach
          response = await apiService.listStock();
          break;
        case 'History Pengajuan':
          //history pengajuan inventaris
          response = await apiService.historyPeminjamanInventaris();
          break;
        case 'Barang':
          //inventory yang dipinjam
          response = await apiService.borrowedItem();
          break;
        default:
          Get.snackbar("Error", "Kategori tidak dikenali");
          return;
      }

      if (response.statusCode == 200) {
        switch (category) {
          case 'Stock Inventaris':
            stockList.assignAll(StockListResponse.fromJson(response.body).data);
            break;
          case 'History Pengajuan':
            historyList.assignAll(
              HistoryInventoryResponse.fromJson(response.body).data,
            );
            break;
          case 'Barang':
            borrowedList.assignAll(
              BorrowedItemResponse.fromJson(response.body).data,
            );
            break;
        }
      } else {
        Get.snackbar("Error", "Unexpected response format");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoading(false);
    }
  }
}
