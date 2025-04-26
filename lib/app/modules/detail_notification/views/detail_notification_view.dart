import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_dev_wave_coach/app/modules/detail_notification/controllers/detail_notification_controller.dart';

class DetailNotificationView extends GetView<DetailNotificationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Notifikasi')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        final detail = controller.notificationDetail.value?.data;
        if (detail == null) {
          return Center(child: Text('Data tidak ditemukan.'));
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Text(
                detail.title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(detail.message),
              SizedBox(height: 16),
              Text('Dibuat pada: ${detail.createdAt}'),
              SizedBox(height: 16),
              Text('Dikirim oleh: ${detail.pengirim.name}'),
              SizedBox(height: 16),
              Divider(),
              Text(
                'Detail Item:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              _buildItems(detail.type, detail.items),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildItems(String type, dynamic items) {
    switch (type) {
      case 'reschedule':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text('Nama: ${items['name']}')],
        );
      case 'return':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Item: ${items['item_name']}'),
            Text('Jumlah: ${items['quantity']}'),
          ],
        );
      case 'request':
        if (items is List) {
          return Column(
            children:
                items.map<Widget>((item) {
                  return ListTile(
                    title: Text(item['item_name']),
                    subtitle: Text('Jumlah: ${item['quantity']}'),
                  );
                }).toList(),
          );
        } else {
          return Text('Data item tidak valid.');
        }
      case 'schedule':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ringkasan: ${items['schedule_summary']}'),
            Text('Lokasi: ${items['location']}'),
          ],
        );
      default:
        return Text('Tipe tidak dikenali.');
    }
  }
}
