import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/inventaris_controller.dart';

class InventarisView extends GetView<InventarisController> {
  const InventarisView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inventaris'), centerTitle: true),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.stockList.isEmpty) {
          return const Center(child: Text("Tidak ada data inventaris."));
        }

        return ListView.builder(
          itemCount: controller.stockList.length,
          itemBuilder: (context, index) {
            final stock = controller.stockList[index];
            return Card(
              margin: const EdgeInsets.all(8),
              child: ExpansionTile(
                title: Text(
                  stock.mastercoachName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children:
                    stock.items.map((item) {
                      return ListTile(
                        title: Text(item.inventoryName),
                        subtitle: Text("Total: ${item.totalQty}"),
                      );
                    }).toList(),
              ),
            );
          },
        );
      }),
    );
  }
}
