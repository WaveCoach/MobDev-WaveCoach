import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert'; // untuk jsonDecode

import 'app/routes/app_pages.dart';
import 'package:mob_dev_wave_coach/app/core/services/api_service.dart';

// Notifikasi Plugin Global
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  await GetStorage.init();
  await _initializeNotifications();

  String pusherApiKey = dotenv.env['PUSHER_API_KEY'] ?? '';
  String pusherCluster = dotenv.env['PUSHER_CLUSTER'] ?? '';

  final box = GetStorage();
  String? userId = box.read('user_id')?.toString();

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

  pusher.onEvent = (PusherEvent event) async {
    print(
      'Received event: ${event.eventName}, Channel: ${event.channelName}, Data: ${event.data}',
    );

    try {
      Map<String, dynamic> data = jsonDecode(event.data);

      String title = data['title'] ?? 'Notifikasi';
      String message = data['message'] ?? 'Pesan baru diterima';

      await showNotification(title: title, body: message);
    } catch (e) {
      print('Gagal memproses event data: $e');
    }
  };

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

// Inisialisasi Notifikasi
Future<void> _initializeNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

// Fungsi untuk Menampilkan Notifikasi
Future<void> showNotification({
  required String title,
  required String body,
}) async {
  try {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'your_channel_id', // Ganti sesuai kebutuhan
          'Your Channel Name', // Ganti sesuai kebutuhan
          importance: Importance.max,
          priority: Priority.high,
        );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      0, // ID Notifikasi
      title,
      body,
      notificationDetails,
    );
  } catch (e) {
    print('Error displaying notification: $e');
  }
}
