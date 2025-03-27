import 'dart:io';
import 'package:get/get.dart';
import 'package:camera/camera.dart';

class CameraLocationController extends GetxController {
  Rxn<CameraDescription> camera = Rxn<CameraDescription>();
  var capturedImagePath = ''.obs;
  @override
  void onInit() {
    super.onInit();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      camera.value = cameras.first;
      update();
    }
  }

  void setCapturedImage(String path) {
    capturedImagePath.value = path;
    Get.back(result: path);
  }
}
