import 'package:get/get.dart';
import 'package:mob_dev_wave_coach/app/core/services/api_service.dart';
import 'package:mob_dev_wave_coach/app/modules/detail_inventaris/model/borrowing_data.dart';
import 'package:mob_dev_wave_coach/app/modules/detail_inventaris/model/borrowing_response.dart';

class DetailInventarisController extends GetxController {
  final apiService = Get.find<ApiService>();
  final isLoading = false.obs;
  final borrowingList = <BorrowingData>[].obs;

  late final int id;

  @override
  void onInit() {
    super.onInit();
    id = Get.arguments;
    fetchBorrowingList(id);
  }

  Future<void> fetchBorrowingList(int id) async {
    isLoading.value = true;
    final response = await apiService.getDetailBorrowingList(id);
    isLoading.value = false;

    if (response.statusCode == 200 && response.body != null) {
      final data = BorrowingResponse.fromJson(response.body).data;
      borrowingList.value = data;
      print("Borrowing List: ${borrowingList.length}");
    } else {
      Get.snackbar("Error", "Failed to load borrowing list");
    }
  }

  Future<void> refreshBorrowingList() async {
    await fetchBorrowingList(id);
  }
}
