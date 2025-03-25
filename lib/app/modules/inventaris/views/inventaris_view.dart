import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mob_dev_wave_coach/app/core/values/app_colors.dart';
import '../controllers/inventaris_controller.dart';
import 'package:intl/intl.dart';

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
    Widget ajukanPeminjaman() {
      return Positioned(
        bottom: 120,
        left: 20,
        right: 20,
        child: ElevatedButton(
          onPressed: () {
            // Add your onPressed code here!
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 8),
            backgroundColor: AppColors.honeyGold,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.edit, color: Colors.white, size: 24),
              SizedBox(width: 8),
              Text(
                'Ajukan Peminjaman',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                  color: Colors.white,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.skyBlue,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 80), // Memberikan jarak dari layar atas
                Text(
                  'Inventaris',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 40,
                    color: Colors.black,
                    letterSpacing: -0.3,
                  ),
                ),
                _selectBoxMenu(),
                SizedBox(height: 25),
                Expanded(child: _buildContent()),
              ],
            ),
          ),
          if (dropdownValue == "Barang") ajukanPeminjaman(),
        ],
      ),
    );
  }

  Widget _selectBoxMenu() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.deepOceanBlue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButton<String>(
        value: dropdownValue,
        icon: Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
          ), // Add spacing between icon and text
          child: Icon(Icons.arrow_drop_down, color: Colors.white),
        ),
        iconSize: 24,
        elevation: 16,
        underline: Container(height: 2, color: AppColors.deepOceanBlue),
        style: TextStyle(color: AppColors.deepOceanBlue),
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
                child: StatefulBuilder(
                  builder: (context, setState) {
                    bool isSelected = value == dropdownValue;
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      decoration: BoxDecoration(
                        color:
                            isSelected
                                ? AppColors.deepOceanBlue
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        value,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    );
                  },
                ),
              );
            }).toList(),
      ),
    );
  }

  Widget _buildContent() {
    if (dropdownValue == "Barang") {
      return _BorrowedItem();
    } else if (dropdownValue == "History Pengajuan") {
      return _HistoryPeminjamanInventaris();
    } else {
      return _StockList();
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
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.historyList.isEmpty) {
        return const Center(child: Text("Tidak ada data history."));
      }

      final filterOptions = ["Semua", "Masuk", "Keluar"];

      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: filterOptions.map((filter) {
              return Container(
                margin: EdgeInsets.only(right: 8),
                width: 80,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(filter, style: TextStyle(fontSize: 16)),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          Container(
            height: 50,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.search, color: Colors.black54),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search by Keywords",
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                      ),
                    ),
                    onChanged: (value) {
                      // Add your search logic here
                      // controller.searchHistoryItems(value);
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 25),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(bottom: 120),
              itemCount: controller.historyList.length,
              itemBuilder: (context, index) {
                final history = controller.historyList[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(
                      history.coachName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "Status: ${DateFormat('dd MMMM yyyy, HH:mm').format(DateTime.parse(history.createdAt))}\nType: ${history.type == 'request' ? 'Pengajuan Peminjaman Inventaris' : 'Pengajuan pengembalian inventaris'}",
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    });
  }

  Widget _BorrowedItem() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.borrowedList.isEmpty) {
        return const Center(child: Text("Tidak ada data peminjaman"));
      }

      return Column(
        children: [
          Container(
            height: 50,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.search, color: Colors.black54),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search by Keywords",
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                      ),
                    ),
                    onChanged: (value) {
                      // Add your search logic here
                      // controller.searchBorrowedItems(value);
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 25),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 1.2,
              ),
              padding: EdgeInsets.only(bottom: 190),
              itemCount: controller.borrowedList.length,
              itemBuilder: (context, index) {
                var item = controller.borrowedList[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
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
            ),
          ),
        ],
      );
    });
  }
}
