import 'package:get/get.dart';
import 'package:map_camera_flutter/map_camera_flutter.dart';
import '../controllers/camera_location_controller.dart';

class CameraLocationView extends StatelessWidget {
  const CameraLocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CameraLocationController>(
      init: CameraLocationController(),
      builder: (controller) {
        if (!Get.isRegistered<CameraLocationController>() ||
            controller.camera == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Camera Location'),
            centerTitle: true,
          ),
          body: MapCameraLocation(
            camera: controller.camera!,
            onImageCaptured: (ImageAndLocationData data) {
              print('Captured image path: ${data.imagePath}');
              print('Latitude: ${data.latitude}');
              print('Longitude: ${data.longitude}');
              print('Location name: ${data.locationName}');
              print('Sublocation: ${data.subLocation}');
            },
          ),
        );
      },
    );
  }
}
