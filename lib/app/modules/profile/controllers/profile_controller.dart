import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  final box = GetStorage();

  void logout() {
    box.remove('token');
    Get.offAllNamed('/sign-in');
  }
}
