import 'dart:io'; // Tambahkan untuk menangani SocketException
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mob_dev_wave_coach/app/modules/inventaris/model/borrowed_item_model.dart';
import 'package:mob_dev_wave_coach/app/modules/inventaris/model/history_inventory_model.dart';
import 'package:mob_dev_wave_coach/app/modules/inventaris/model/stock_list_model.dart';
import 'package:mob_dev_wave_coach/app/core/utils/loading_helper.dart';

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
  final selectedFilter = 'Semua'.obs;
  final roleId = ''.obs;

  String? dropdownValue;

  @override
  void onInit() {
    super.onInit();
    roleId.value = GetStorage().read("roleId")?.toString() ?? "";
    fetchInventaris('Barang');
    fetchInventaris('History Pengajuan', filter: 'Semua');
  }

  Future<void> fetchInventaris(
    String category, {
    String filter = 'Semua',
  }) async {
    await wrapLoading(isLoading, () async {
      try {
        final response = switch (category) {
          'Stock Inventaris' => await apiService.listStock(),
          'History Pengajuan' => await apiService.historyPeminjamanInventaris(
            filter: filter,
          ),
          'Barang' => await apiService.borrowedItem(),
          _ => null,
        };

        if (response == null) {
          Get.snackbar("Error", "Kategori tidak dikenali");
          return;
        }

        if (response.statusCode == 200) {
          final body = response.body ?? {};

          switch (category) {
            case 'Stock Inventaris':
              stockList.value = StockListResponse.fromJson(body).data ?? [];
              break;
            case 'History Pengajuan':
              historyList.value =
                  HistoryInventoryResponse.fromJson(body).data ?? [];
              break;
            case 'Barang':
              borrowedList.value =
                  BorrowedItemResponse.fromJson(body).data ?? [];
              break;
          }
        } else {
          logError("fetch $category", response.statusCode);
          Get.snackbar(
            "Error $category",
            "Unexpected response (${response.statusCode})",
          );
        }
      } on SocketException catch (e) {
        logError("SocketException $category", e.message);
        Get.snackbar("Timeout", "Gagal mengambil $category: Koneksi gagal.");
      } catch (e) {
        logError("Exception $category", e.toString());
        Get.snackbar("Error", "Gagal mengambil $category: ${e.toString()}");
      }
    });
  }
}
