import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  final box = GetStorage();
  late final String storedName;
  late final String storedEmail;
  var name = ''.obs;
  var email = ''.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    storedName = box.read("name") ?? " ";
    name.value = storedName;
    storedEmail = box.read("email") ?? " ";
    email.value = storedEmail;
    super.onInit();
  }

  void logout() {
    box.remove('token');
    Get.offAllNamed('/sign-in');
  }
}
