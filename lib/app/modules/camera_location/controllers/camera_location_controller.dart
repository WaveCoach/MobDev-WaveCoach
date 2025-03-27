import 'package:get/get.dart';
import 'package:camera/camera.dart';

class CameraLocationController extends GetxController {
  late CameraDescription? camera;

  @override
  void onInit() async {
    super.onInit();
    await _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      camera = cameras.first;
      update();
    }
  }
}
