import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mob_dev_wave_coach/app/core/values/app_colors.dart';
import 'package:mob_dev_wave_coach/app/modules/ajukan_peminjaman/model/inventory_matercoach_model.dart';
import 'package:mob_dev_wave_coach/app/modules/ajukan_peminjaman/model/mastercoach_model.dart';

import '../controllers/ajukan_peminjaman_controller.dart';

class AjukanPeminjamanView extends GetView<AjukanPeminjamanController> {
  const AjukanPeminjamanView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0, // Adjust spacing between back icon and title
        title: Text(
          "Kembali",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: AppColors.deepOceanBlue,
        iconTheme: const IconThemeData(color: Colors.white),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark, // Set icons to dark (gray)
          statusBarColor:
              Colors.transparent, // Optional: Make status bar transparent
        ),
      ),
      backgroundColor: AppColors.skyBlue,
      body: Column(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.deepOceanBlue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Center(
              child: Text(
                "Ajukan\nPeminjaman",
                textAlign: TextAlign.center, // Set text alignment to center
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                  letterSpacing: -0.5,
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      "Nama Peminjam",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  _buildNameInput(controller),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      "Nama Master Coach",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  _buildMasterCoachInput(controller),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      "Nama Barang",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  _buildStuffDropdown(controller),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      "Tanggal Peminjaman",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  _buildBorrowDateInput(),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      "Tanggal Pengembalian",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  _buildReturnDateInput(),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      "Deskripsi",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  _buildDescInput(),
                  const SizedBox(height: 16),
                  _buildSubmitButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNameInput(AjukanPeminjamanController controller) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          border: Border.all(color: Colors.grey),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextFormField(
            controller: TextEditingController(text: controller.name.value),
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: Colors.black,
            ),
            decoration: const InputDecoration(
              hintText: "Nama Coach",
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
            ),

            readOnly: true,
          ),
        ),
      ),
    );
  }

  Widget _buildMasterCoachInput(AjukanPeminjamanController controller) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          border: Border.all(color: Colors.black.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: DropdownButtonFormField<MasterCoach>(
            value: controller.selectedMatercoach.value,
            decoration: const InputDecoration(
              hintText: "Pilih Master Coach",
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
            ),
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize: 15,
              color: Colors.black,
            ),
            isExpanded: true,
            items: controller.masterCoachList
                .map(
                  (masterCoach) => DropdownMenuItem<MasterCoach>(
                    value: masterCoach,
                    child: Text(masterCoach.name ?? "-"),
                  ),
                )
                .toList(),
            onChanged: (value) {
              controller.selectedMatercoach.value = value;
              controller.fetchInventory();
              
              // Clear the list but ensure one empty item remains
              controller.stuffFormList.clear();
              controller.stuffFormList.add({
                'selectedStuff': null,
                'quantity': '',
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _buildStuffDropdown(AjukanPeminjamanController controller) {
    return Obx(() {
      return Column(
        children: [
          ...controller.stuffFormList.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, dynamic> stuff = entry.value;

            // Filter barang yang sudah dipilih
            List<InventoryItem> availableItems = controller.stuffList.where((item) {
              return !controller.stuffFormList.any((form) =>
                  form['selectedStuff']?.inventoryId == item.inventoryId &&
                  form != stuff); // Exclude the current item
            }).toList();

            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black.withOpacity(0.2),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: DropdownButtonFormField<InventoryItem>(
                          decoration: const InputDecoration(
                            hintText: "Pilih Barang",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          ),
                          isExpanded: true,
                          value: stuff['selectedStuff'],
                          items: availableItems.map((item) {
                            return DropdownMenuItem<InventoryItem>(
                              value: item,
                              child: Text(item.inventoryName ?? "-"),
                            );
                          }).toList(),
                          onChanged: (value) {
                            stuff['selectedStuff'] = value;
                            controller.stuffFormList[index] = {
                              ...stuff,
                            }; // trigger Obx
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black.withOpacity(0.2),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: TextFormField(
                          key: ValueKey(
                            "qty-${stuff['selectedStuff']?.inventoryId ?? index}",
                          ),
                          decoration: const InputDecoration(
                            hintText: "Jumlah",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.number,
                          initialValue: stuff['quantity']?.toString(),
                          onChanged: (value) {
                            stuff['quantity'] = value;
                            controller.stuffFormList[index] = {...stuff};
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: const Icon(Icons.remove_circle),
                    color: Colors.red,
                    onPressed: controller.stuffFormList.length > 1
                        ? () {
                            controller.stuffFormList.removeAt(index);
                          }
                        : null, // Disable button if only one item remains
                  ),
                ],
              ),
            );
          }).toList(),
          ElevatedButton(
            onPressed: () {
              controller.stuffFormList.add({
                'selectedStuff': null,
                'quantity': '',
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.goldenAmber,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ), // Padding untuk menyesuaikan ukuran
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min, // Adjust size to fit content
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: Colors.white, // White circle background
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.add, // Icon "+"
                    color: Colors.black,
                    size: 14, // Adjust icon size
                  ),
                ),
                const SizedBox(width: 8), // Space between icon and text
                const Text(
                  "Tambah Stuff",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      );
    });
  }

  Widget _buildBorrowDateInput() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: Colors.black.withOpacity(0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller.dateBorrowController,
                decoration: const InputDecoration(
                  hintText: "Pilih Tanggal Peminjaman",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: Get.context!,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    controller.dateBorrowController.text =
                        "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                  }
                },
              ),
            ),
            const Icon(
              Icons.calendar_today, // Ikon kalender
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReturnDateInput() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: Colors.black.withOpacity(0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller.dateReturnController,
                decoration: const InputDecoration(
                  hintText: "Pilih Tanggal Pengembalian",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: Get.context!,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    controller.dateReturnController.text =
                        "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                  }
                },
              ),
            ),
            const Icon(
              Icons.calendar_today, // Ikon kalender
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDescInput() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: Colors.black.withOpacity(0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: TextFormField(
          controller: controller.descController,
          decoration: const InputDecoration(
              hintText: "Ketik Disini",
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
            alignLabelWithHint: true, // Align label with the top-left corner
          ),
          maxLines: 3,
          textAlign: TextAlign.start, // Align text to the top-left corner
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: ElevatedButton(
          onPressed: () {
            controller.submitPengajuan();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.goldenAmber,
            minimumSize: Size(double.infinity, 64),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: const Text(
            "Submit",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
