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
        if (controller.camera.value == null) {
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
            camera: controller.camera.value!, // Gunakan .value
            onImageCaptured: (ImageAndLocationData data) {
              if (data.imagePath != null) {
                print('halo');

                controller.setCapturedImage(data.imagePath!);
              } else {
                // Handle the case where imagePath is null
                print('Error: imagePath is null');
              }
              // print('Captured image path: ${data.imagePath}');
              // print('Latitude: ${data.latitude}');
              // print('Longitude: ${data.longitude}');
              // print('Location name: ${data.locationName}');
              // print('Sublocation: ${data.subLocation}');
            },
          ),
        );
      },
    );
  }
}
