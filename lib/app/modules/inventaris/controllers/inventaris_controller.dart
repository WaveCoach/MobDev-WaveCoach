import 'package:get/get.dart';
import 'package:mob_dev_wave_coach/app/core/services/api_service.dart';
import 'package:mob_dev_wave_coach/app/modules/inventaris/model/stock_list_model.dart';
import 'package:mob_dev_wave_coach/app/modules/inventaris/model/stock_list_response.dart';

class InventarisController extends GetxController {
  var isLoading = false.obs;
  var stockList = <StockListModel>[].obs;
  final ApiService apiService = Get.find<ApiService>();

  @override
  void onInit() {
    fetchStockList();
    super.onInit();
  }

  void fetchStockList() async {
    try {
      isLoading(true);
      final response = await apiService.listStock();

      if (response.statusCode == 200 && response.body != null) {
        if (response.body is Map<String, dynamic>) {
          try {
            var stockListResponse = StockListResponse.fromJson(response.body);
            stockList.assignAll(stockListResponse.data);
          } catch (e) {
            Get.snackbar("Error", "Invalid response format: $e");
          }
        } else {
          Get.snackbar("Error", "Unexpected response format");
        }
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoading(false);
    }
  }
}
