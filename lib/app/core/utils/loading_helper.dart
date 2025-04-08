import 'package:get/get.dart';

Future<void> wrapLoading(RxBool isLoading, Future<void> Function() func) async {
  try {
    isLoading.value = true;
    await func();
  } catch (e) {
    print("Unexpected error: $e");
    Get.snackbar("Error", "An error occurred: $e");
  } finally {
    isLoading.value = false;
  }
}

void logError(String context, dynamic status) {
  print("Failed to $context: $status");
}
