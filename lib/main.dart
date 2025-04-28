import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app/routes/app_pages.dart';
import 'package:mob_dev_wave_coach/app/core/services/api_service.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await GetStorage.init();

  String pusherApiKey = dotenv.env['PUSHER_API_KEY'] ?? '';
  String pusherCluster = dotenv.env['PUSHER_CLUSTER'] ?? '';

  print('Pusher API Key: $pusherApiKey');
  print('Pusher Cluster: $pusherCluster');

  final box = GetStorage();
  String? userId = box.read('user_id')?.toString(); // pastikan string

  if (userId == null) {
    print('User ID tidak ditemukan di storage!');
    return;
  }

  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

  await pusher.init(
    apiKey: pusherApiKey,
    cluster: pusherCluster,
    onConnectionStateChange: (currentState, previousState) {
      print('Connection state changed from $previousState to $currentState');
    },
    onError: (String message, int? code, dynamic exception) {
      print('Pusher error: $message, Code: $code, Exception: $exception');
    },
  );

  await pusher.connect();

  String channelName = 'notification-channel-user-$userId';
  await pusher.subscribe(channelName: channelName);

  pusher.onEvent = (PusherEvent event) {
    print(
      'Received event: ${event.eventName}, Channel: ${event.channelName}, Data: ${event.data}',
    );
  };

  // Masukkan ApiService dan jalankan aplikasi Flutter
  Get.put(ApiService());
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
