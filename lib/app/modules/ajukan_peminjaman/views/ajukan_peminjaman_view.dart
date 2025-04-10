import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
            _buildNameInput(),
            const SizedBox(height: 16),
            _buildMasterCoachInput(),
            const SizedBox(height: 16),
            _buildStuffDropdown(),
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

  Widget _buildNameInput() {
    return TextFormField(
      // controller: controller.nameController,
      decoration: const InputDecoration(
        labelText: "Nama Lengkap",
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildMasterCoachInput() {
    return TextFormField(
      // controller: controller.masterCoachController,
      decoration: const InputDecoration(
        labelText: "Nama Master Coach",
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildStuffDropdown() {
    List<Map<String, dynamic>> stuffList = [
      {'selectedStuff': null, 'quantity': ''},
    ];

    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          children: [
            ...stuffList.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> stuff = entry.value;
              return Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: "Pilih Stuff",
                        border: OutlineInputBorder(),
                      ),
                      value: stuff['selectedStuff'],
                      items:
                          ["Stuff 1", "Stuff 2", "Stuff 3"].map((item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                      onChanged: (value) {
                        setState(() {
                          stuff['selectedStuff'] = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Jumlah",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      initialValue: stuff['quantity'],
                      onChanged: (value) {
                        setState(() {
                          stuff['quantity'] = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: const Icon(Icons.remove_circle),
                    color: Colors.red,
                    onPressed: () {
                      setState(() {
                        stuffList.removeAt(index);
                      });
                    },
                  ),
                ],
              );
            }).toList(),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  stuffList.add({'selectedStuff': null, 'quantity': ''});
                });
              },
              child: const Text("Tambah Stuff"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBorrowDateInput() {
    return TextFormField(
      // controller: controller.borrowDateController,
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
          // controller.borrowDateController.text =
          //     "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
        }
      },
    );
  }

  Widget _buildReturnDateInput() {
    return TextFormField(
      // controller: controller.returnDateController,
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
          // controller.returnDateController.text =
          //     "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
        }
      },
    );
  }

  Widget _buildDescInput() {
    return TextFormField(
      // controller: controller.descController,
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
          // controller.submitForm();
        },
        child: const Text("Ajukan Peminjaman"),
      ),
    );
  }
}
