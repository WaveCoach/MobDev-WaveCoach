import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mob_dev_wave_coach/app/core/values/app_colors.dart';
import 'package:mob_dev_wave_coach/app/routes/app_pages.dart';
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
  String searchQuery = ""; // Tambahkan properti untuk menyimpan input pencarian

  @override
  void initState() {
    super.initState();
    dropdownValue = 'Barang';
  }

  @override
  Widget build(BuildContext context) {
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
          if (dropdownValue != null && dropdownValue == "Barang")
            ajukanPeminjaman(),
        ],
      ),
    );
  }

  Widget ajukanPeminjaman() {
    return Positioned(
      bottom: 120,
      left: 20,
      right: 20,
      child: ElevatedButton(
        onPressed: () {
          Get.toNamed(Routes.AJUKAN_PEMINJAMAN);
          // debugPrint("Ajukan Peminjaman button pressed");
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

      final filteredStockList =
          controller.stockList.where((stock) {
            final matchesMasterCoach = stock.mastercoachName
                .toLowerCase()
                .contains(searchQuery.toLowerCase());
            final matchesItems = stock.items.any(
              (item) => item.inventoryName.toLowerCase().contains(
                searchQuery.toLowerCase(),
              ),
            );
            return matchesMasterCoach || matchesItems;
          }).toList();

      return RefreshIndicator(
        onRefresh: () async {
          controller.stockList(); // Panggil fungsi untuk memuat ulang data
        },
        child: Column(
          children: [
            // Search Bar
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
                        hintText: "Search by Master Coach or Item Name",
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black54,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value; // Perbarui input pencarian
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),
            // Daftar stok yang difilter
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(bottom: 120),
                itemCount: filteredStockList.length,
                itemBuilder: (context, index) {
                  final stock = filteredStockList[index];

                  // Filter items dengan totalQty >= 1
                  final filteredItems =
                      stock.items.where((item) => item.totalQty >= 1).toList();

                  if (filteredItems.isEmpty) {
                    return SizedBox(); // Skip rendering jika tidak ada item yang memenuhi kondisi
                  }

                  return Column(
                    children: [
                      Card(
                        color: Colors.transparent,
                        elevation: 0,
                        child: Theme(
                          data: Theme.of(
                            context,
                          ).copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            title: Row(
                              children: [
                                stock.mastercoachImageUrl != null &&
                                        stock.mastercoachImageUrl!.isNotEmpty
                                    ? ClipOval(
                                      child: Image.network(
                                        stock.mastercoachImageUrl ?? '',
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                    : Icon(
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
                                  ...filteredItems.asMap().entries.map((entry) {
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
                                            index.toString(),
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              color: AppColors.deepOceanBlue,
                                            ),
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
                                            item.totalQty.toString(),
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              color: AppColors.deepOceanBlue,
                                            ),
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
                          color: Colors.black.withOpacity(0.18),
                          thickness: 1,
                          height: 1,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _historyPeminjamanInventaris() {
    return Obx(() {
      final filterOptions = ["Semua", "Masuk", "Keluar"];

      // Filter daftar history berdasarkan input pencarian
      final filteredHistoryList = controller.historyList.where((history) {
        final matchesCoachName = history.coachName
            .toLowerCase()
            .contains(searchQuery.toLowerCase());
        final matchesTitle = history.type == 'request'
            ? 'Pengajuan Peminjaman Inventaris'
                .toLowerCase()
                .contains(searchQuery.toLowerCase())
            : 'Pengajuan Pengembalian Inventaris'
                .toLowerCase()
                .contains(searchQuery.toLowerCase());
        final matchesDate = DateFormat('dd MMMM yyyy, HH:mm')
            .format(DateTime.parse(history.createdAt))
            .toLowerCase()
            .contains(searchQuery.toLowerCase());

        return matchesCoachName || matchesTitle || matchesDate;
      }).toList();

      return Column(
        children: [
          Obx(() {
            if (controller.roleId.value == '3') {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children:
                    filterOptions.map((filter) {
                      final isSelected =
                          controller.selectedFilter.value == filter;
                      return GestureDetector(
                        onTap: () {
                          controller.selectedFilter.value = filter;
                          controller.fetchInventaris(
                            'History Pengajuan',
                            filter: filter,
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 8),
                          width: 80,
                          height: 30,
                          decoration: BoxDecoration(
                            color:
                                isSelected
                                    ? AppColors.deepOceanBlue
                                    : Colors.white,
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
                            child: Text(
                              filter,
                              style: TextStyle(
                                fontSize: 16,
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
              );
            } else {
              return SizedBox.shrink(); // Return an empty widget if roleId is not '3'
            }
          }),
          SizedBox(height: 20),
          // Search Bar
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
                      setState(() {
                        searchQuery = value; // Perbarui input pencarian
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 25),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                // Panggil fungsi untuk memuat ulang data historyList
                await controller.fetchInventaris('History Pengajuan');
              },
              child: filteredHistoryList.isEmpty
                  ? Center(
                      child: Text(
                        "Data kosong",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.only(bottom: 110),
                      itemCount: filteredHistoryList.length,
                      itemBuilder: (context, index) {
                        final history = filteredHistoryList[index];
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(
                              Routes.DETAIL_HISTORY_PENGAJUAN,
                              arguments: {
                                'id': history.id,
                                'type': history.type,
                              },
                            );
                          },
                          child: Container(
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
                                    child: Stack(
                                      children: [
                                        Center(
                                          child: Icon(
                                            Icons.description,
                                            color: Colors.white,
                                            size: 50,
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 8,
                                          right: 8,
                                          child: Icon(
                                            history.type == 'request'
                                                ? Icons.south_west // Panah ke bawah untuk ajuan masuk
                                                : Icons.north_east,   // Panah ke atas untuk ajuan keluar
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      ],
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 2,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: AppColors.goldenAmber,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        100,
                                                      ),
                                                ),
                                                child: Text(
                                                  DateFormat(
                                                    'dd MMMM yyyy, HH:mm',
                                                  ).format(
                                                    DateTime.parse(
                                                      history.createdAt,
                                                    ),
                                                  ),
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                    letterSpacing: -0.5,
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Icon(
                                                history.status == 'approved'
                                                    ? Icons.check_circle
                                                    : history.status ==
                                                        'pending'
                                                    ? Icons.access_time_filled
                                                    : Icons.cancel,
                                                color:
                                                    history.status == 'approved'
                                                        ? Colors.green
                                                        : history.status ==
                                                            'pending'
                                                        ? AppColors.honeyGold
                                                        : Colors.red,
                                              ),
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
                                              history.imageUrlHistory != null &&
                                                      history
                                                          .imageUrlHistory!
                                                          .isNotEmpty
                                                  ? ClipOval(
                                                    child: Image.network(
                                                      history.imageUrlHistory!,
                                                      width: 24,
                                                      height: 24,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                                  : Icon(
                                                    Icons.person,
                                                    color: Colors.black,
                                                  ),
                                              SizedBox(width: 6),
                                              Row(
                                                children: [
                                                  Text(
                                                    history.coachName,
                                                    style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                    ),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                          ),
                        );
                      },
                    ),
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

      // Filter daftar barang berdasarkan input pencarian
      final filteredList =
          controller.borrowedList.where((item) {
            return item.name.toLowerCase().contains(searchQuery.toLowerCase());
          }).toList();

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
                      setState(() {
                        searchQuery = value; // Perbarui input pencarian
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 25),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                // Panggil fungsi untuk memuat ulang data borrowedList
                await controller.fetchInventaris('Barang');
              },
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 1,
                ),
                padding: EdgeInsets.only(bottom: 190),
                itemCount:
                    filteredList.length, // Gunakan daftar yang sudah difilter
                itemBuilder: (context, index) {
                  var item = filteredList[index];
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(
                        Routes.DETAIL_INVENTARIS,
                        arguments: item.inventoryId,
                      );
                    },
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 10, 15, 50),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child:
                                  item.imageUrl?.isNotEmpty ?? false
                                      ? Image.network(
                                        item.imageUrl ?? '',
                                        height: double.infinity,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      )
                                      : Image.asset(
                                        'assets/images/onboarding1.png',
                                        height: double.infinity,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
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
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
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
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      );
    });
  }
}
