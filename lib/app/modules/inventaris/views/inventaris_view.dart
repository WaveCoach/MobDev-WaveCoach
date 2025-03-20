import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_dev_wave_coach/app/core/values/app_colors.dart';
import '../controllers/inventaris_controller.dart';

class InventarisView extends StatefulWidget {
  const InventarisView({super.key});

  @override
  _InventarisViewState createState() => _InventarisViewState();
}

class _InventarisViewState extends State<InventarisView> {
  final InventarisController controller = Get.put(InventarisController());
  String? dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = 'Barang'; // Set nilai default dropdown
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.skyBlue,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_selectBoxMenu(), Expanded(child: _StockList())],
        ),
      ),
    );
  }

  Widget _selectBoxMenu() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.pastelBlue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButton<String>(
        value: dropdownValue,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(color: AppColors.deepOceanBlue),
        underline: Container(height: 2, color: AppColors.deepOceanBlue),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue;
          });
        },
        items:
            [
              'Barang',
              'History Pengajuan',
              'Stock Inventaris',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(color: AppColors.deepOceanBlue),
                ),
              );
            }).toList(),
      ),
    );
  }

  Widget _StockList() {
    return Obx(() {
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
    });
  }
}
