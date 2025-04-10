import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mob_dev_wave_coach/app/modules/ajukan_peminjaman/model/inventory_matercoach_model.dart';
import 'package:mob_dev_wave_coach/app/modules/ajukan_peminjaman/model/mastercoach_model.dart';

import '../controllers/ajukan_peminjaman_controller.dart';

class AjukanPeminjamanView extends GetView<AjukanPeminjamanController> {
  const AjukanPeminjamanView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AjukanPeminjamanView'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNameInput(controller),
            const SizedBox(height: 16),
            _buildMasterCoachInput(controller),
            const SizedBox(height: 16),
            _buildStuffDropdown(controller),
            const SizedBox(height: 16),
            _buildBorrowDateInput(),
            const SizedBox(height: 16),
            _buildReturnDateInput(),
            const SizedBox(height: 16),
            _buildDescInput(),
            const SizedBox(height: 16),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildNameInput(AjukanPeminjamanController controller) {
    return Obx(
      () => TextFormField(
        initialValue: controller.name.value,
        readOnly: true,
        decoration: const InputDecoration(
          labelText: "Nama Lengkap",
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildMasterCoachInput(AjukanPeminjamanController controller) {
    return Obx(
      () => DropdownButtonFormField<MasterCoach>(
        value: controller.selectedMatercoach.value,
        decoration: const InputDecoration(
          labelText: "Nama Master Coach",
          border: OutlineInputBorder(),
        ),
        isExpanded: true,
        items:
            controller.masterCoachList
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
        },
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

            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: DropdownButtonFormField<InventoryItem>(
                      decoration: const InputDecoration(
                        labelText: "Pilih Stuff",
                        border: OutlineInputBorder(),
                      ),
                      isExpanded: true,
                      value: stuff['selectedStuff'],
                      items:
                          controller.stuffList.map((item) {
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
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      key: ValueKey(
                        "qty-${stuff['selectedStuff']?.id ?? index}",
                      ),
                      decoration: const InputDecoration(
                        labelText: "Jumlah",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      initialValue: stuff['quantity']?.toString(),
                      onChanged: (value) {
                        stuff['quantity'] = value;
                        controller.stuffFormList[index] = {...stuff};
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: const Icon(Icons.remove_circle),
                    color: Colors.red,
                    onPressed: () {
                      controller.stuffFormList.removeAt(index);
                    },
                  ),
                ],
              ),
            );
          }).toList(),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              controller.stuffFormList.add({
                'selectedStuff': null,
                'quantity': '',
              });
            },
            child: const Text("Tambah Stuff"),
          ),
        ],
      );
    });
  }

  Widget _buildBorrowDateInput() {
    return TextFormField(
      controller: controller.dateBorrowController,
      decoration: const InputDecoration(
        labelText: "Tanggal Peminjaman",
        border: OutlineInputBorder(),
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
    );
  }

  Widget _buildReturnDateInput() {
    return TextFormField(
      controller: controller.dateReturnController,
      decoration: const InputDecoration(
        labelText: "Tanggal Pengembalian",
        border: OutlineInputBorder(),
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
    );
  }

  Widget _buildDescInput() {
    return TextFormField(
      controller: controller.descController,
      decoration: const InputDecoration(
        labelText: "Deskripsi",
        border: OutlineInputBorder(),
      ),
      maxLines: 3,
    );
  }

  Widget _buildSubmitButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          controller.submitPengajuan();
        },
        child: const Text("Ajukan Peminjaman"),
      ),
    );
  }
}
