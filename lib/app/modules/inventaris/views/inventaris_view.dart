import 'dart:ui';

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
    dropdownValue = 'Barang';
  }

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
      return _borrowedItem();
    } else if (dropdownValue == "History Pengajuan") {
      return _historyPeminjamanInventaris();
    } else if (dropdownValue == "Stock Inventaris") {
      return _stockList();
    } else {
      return _borrowedItem();
    }
  }

  Widget _stockList() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.stockList.isEmpty) {
        return const Center(child: Text("Tidak ada stok barang."));
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
            child: ListView.builder(
              padding: EdgeInsets.only(bottom: 120),
              itemCount: controller.stockList.length,
              itemBuilder: (context, index) {
                final stock = controller.stockList[index];
                return Column(
                  children: [
                    Card(
                      color:
                          Colors.transparent, // Card color set to transparent
                      elevation: 0, // Remove shadow by setting elevation to 0
                      child: Theme(
                        data: Theme.of(
                          context,
                        ).copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          title: Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: Colors.black54,
                                size: 40,
                              ),
                              SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Master Coach",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Colors.black,
                                      letterSpacing: -0.3,
                                    ),
                                  ),
                                  Text(
                                    stock.mastercoachName,
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: Colors.black,
                                      letterSpacing: -0.3,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          children: [
                            Table(
                              border: TableBorder.all(color: Colors.white),
                              columnWidths: const {
                                0: FixedColumnWidth(40),
                                1: FlexColumnWidth(),
                                2: FixedColumnWidth(90),
                              },
                              children: [
                                TableRow(
                                  decoration: BoxDecoration(
                                    color: AppColors.deepOceanBlue,
                                  ),
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "No",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Nama Barang",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Jumlah",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                                ...stock.items.asMap().entries.map((entry) {
                                  final index = entry.key + 1;
                                  final item = entry.value;
                                  return TableRow(
                                    decoration: BoxDecoration(
                                      color: AppColors.mildBlue,
                                    ),
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color: AppColors.deepOceanBlue,
                                          ),
                                          index.toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          item.inventoryName,
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color: AppColors.deepOceanBlue,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color: AppColors.deepOceanBlue,
                                          ),
                                          item.totalQty.toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                              ],
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Divider(
                        color: Colors.black.withValues(
                          alpha: 0.18,
                        ), // Warna divider
                        thickness: 1, // Ketebalan divider
                        height: 1, // Tinggi divider
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      );
    });
  }

  Widget _historyPeminjamanInventaris() {
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
            children:
                filterOptions.map((filter) {
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
                      hintStyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.black54,
                        letterSpacing: -0.5,
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
              padding: EdgeInsets.only(bottom: 110),
              itemCount: controller.historyList.length,
              itemBuilder: (context, index) {
                final history = controller.historyList[index];
                return Container(
                  padding: EdgeInsets.only(bottom: 10),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          width: 80,
                          decoration: BoxDecoration(
                            color: AppColors.deepOceanBlue,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.description,
                              color: Colors.white,
                              size: 50,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.lightBlue,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.goldenAmber,
                                        borderRadius: BorderRadius.circular(
                                          100,
                                        ),
                                      ),
                                      child: Text(
                                        DateFormat(
                                          'dd MMMM yyyy, HH:mm',
                                        ).format(
                                          DateTime.parse(history.createdAt),
                                        ),
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: Colors.black,
                                          letterSpacing: -0.5,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Icon(Icons.home, color: Colors.black),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  history.type == 'request'
                                      ? 'Pengajuan Peminjaman Inventaris'
                                      : 'Pengajuan Pengembalian Inventaris',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(Icons.person, color: Colors.black),
                                    SizedBox(width: 6),
                                    Row(
                                      children: [
                                        Text(
                                          history.coachName,
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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

  Widget _borrowedItem() {
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
                childAspectRatio: 1,
              ),
              padding: EdgeInsets.only(bottom: 190),
              itemCount: controller.borrowedList.length,
              itemBuilder: (context, index) {
                var item = controller.borrowedList[index];
                return Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 50),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/images/onboarding1.png', // Replace with your own image path
                            height: double.infinity,
                            width: double.infinity,
                            fit:
                                BoxFit
                                    .cover, // Make the image cover the container
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.center,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xFF8AC4FF).withOpacity(0.0),
                              AppColors.deepOceanBlue.withOpacity(1.0),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                          bottom: 10,
                        ),
                        child: ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      item.name,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                        color: AppColors.midnightNavy,
                                        letterSpacing: -0.3,
                                        height: 1,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      "Jumlah: ${item.totalQtyBorrowed}",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                        color: const Color.fromARGB(
                                          255,
                                          32,
                                          66,
                                          94,
                                        ),
                                        letterSpacing: -0.3,
                                        height: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      );
    });
  }
}
