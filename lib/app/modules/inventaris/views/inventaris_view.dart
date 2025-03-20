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
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_selectBoxMenu(), Expanded(child: _buildContent())],
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
          controller.fetchInventaris(newValue!);
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

  Widget _buildContent() {
    if (dropdownValue == "Barang") {
      return _StockList();
    } else if (dropdownValue == "History Pengajuan") {
      return _HistoryPeminjamanInventaris();
    } else {
      return _BorrowedItem();
    }
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

  Widget _HistoryPeminjamanInventaris() {
    List<Map<String, String>> history = [
      {"name": "Kacamata Renang", "status": "Dikembalikan"},
      {"name": "Pelampung Tangan", "status": "Belum Dikembalikan"},
      {"name": "Papan Pelampung", "status": "Dikembalikan"},
      {"name": "Pelampung Pinggang", "status": "Belum Dikembalikan"},
    ];

    return ListView.builder(
      itemCount: history.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.all(8),
          child: ListTile(
            title: Text(
              history[index]["name"]!,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text("Status: ${history[index]["status"]}"),
            trailing: Icon(
              history[index]["status"] == "Dikembalikan"
                  ? Icons.check_circle
                  : Icons.error,
              color:
                  history[index]["status"] == "Dikembalikan"
                      ? Colors.green
                      : Colors.red,
            ),
          ),
        );
      },
    );
  }

  Widget _BorrowedItem() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.borrowedList.isEmpty) {
        return const Center(child: Text("Tidak ada data peminjaman"));
      }

      return GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 1.2,
        ),
        itemCount: controller.borrowedList.length,
        itemBuilder: (context, index) {
          var item = controller.borrowedList[index];
          return Container(
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
            ),
            padding: EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  "Jumlah: ${item.totalQtyBorrowed}",
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
