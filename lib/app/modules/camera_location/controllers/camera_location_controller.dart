import 'package:get/get.dart';
import 'package:camera/camera.dart';

class CameraLocationController extends GetxController {
  Rxn<CameraDescription> camera = Rxn<CameraDescription>(); // Gunakan Rxn

  @override
  void onInit() {
    super.onInit();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      camera.value = cameras.first; // Gunakan .value untuk menyimpan data
      update(); // Perbarui UI
    }
  }
}
