import 'package:get/get.dart';
import 'package:mob_dev_wave_coach/app/core/services/api_service.dart';

class AjukanPengembalianController extends GetxController {
  final ApiService apiService = Get.find<ApiService>();
  final isLoading = false.obs;
}
