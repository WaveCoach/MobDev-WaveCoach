import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mob_dev_wave_coach/app/core/values/app_colors.dart';
import '../controllers/detail_history_pengajuan_controller.dart';

class DetailHistoryPengajuanView
    extends GetView<DetailHistoryPengajuanController> {
  const DetailHistoryPengajuanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0, // Adjust spacing between back icon and title
        title: Text(
          "Kembali",
          style: GoogleFonts.poppins(
            color: AppColors.deepOceanBlue,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: AppColors.skyBlue,
        iconTheme: const IconThemeData(color: AppColors.deepOceanBlue),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark, // Set icons to dark (gray)
          statusBarColor:
              Colors.transparent, // Optional: Make status bar transparent
        ),
      ),
      backgroundColor: AppColors.skyBlue,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // Cek jika data request tersedia
        if (controller.historyRequestResponse.value != null) {
          final data = controller.historyRequestResponse.value!;
          return Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Dari: ${data.data.coachName}",
                        style: GoogleFonts.poppins(
                          color: Color(0xFF4C4C4C),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          height: 1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Pengajuan Peminjaman Inventaris",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        data.data.tanggalPinjam,
                        style: GoogleFonts.poppins(
                          color: AppColors.deepOceanBlue,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Divider(
                        color: Colors.black.withOpacity(0.2),
                        thickness: 1,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      // Text("ID: ${data.data.id}"),
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
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextFormField(
                            controller: TextEditingController(
                              text: data.data.coachName,
                            ),
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
                      SizedBox(height: 16),
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
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextFormField(
                            controller: TextEditingController(
                              text: data.data.mastercoachName,
                            ),
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
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          "Inventaris & Jumlah",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),

                      Column(
                        children: List.generate(data.data.items.length, (
                          index,
                        ) {
                          final item = data.data.items[index];
                          return Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: AppColors.contrastBlue,
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: TextFormField(
                                      controller: TextEditingController(
                                        text: item.inventoryName,
                                      ),
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                      decoration: const InputDecoration(
                                        hintText: "Nama Inventaris",
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                      readOnly: true,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: AppColors.contrastBlue,
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: TextFormField(
                                      controller: TextEditingController(
                                        text: item.qtyRequested.toString(),
                                      ),
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                      decoration: const InputDecoration(
                                        hintText: "Qty",
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                      readOnly: true,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                      ),

                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          "Tanggal Pinjam",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextFormField(
                            controller: TextEditingController(
                              text: data.data.tanggalPinjam,
                            ),
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            decoration: const InputDecoration(
                              hintText: "Tanggal Pinjam",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),

                            readOnly: true,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          "Tanggal Kembali",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextFormField(
                            controller: TextEditingController(
                              text: data.data.tanggalKembali,
                            ),
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            decoration: const InputDecoration(
                              hintText: "Tanggal Kembali",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),

                            readOnly: true,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          "Alasan Pinjam",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.black.withOpacity(0.2),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: TextFormField(
                            controller: TextEditingController(
                              text: data.data.alasanPinjam,
                            ),
                            decoration: const InputDecoration(
                              hintText: "Ketik Disini",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                              alignLabelWithHint:
                                  true, // Align label with the top-left corner
                            ),
                            maxLines: 3,
                            textAlign:
                                TextAlign
                                    .start, // Align text to the top-left corner
                            readOnly: true, // Make the field read-only
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      //bisakah buatkan label status dan alasan ditolak
                      if (data.data.status == "approved" ||
                          data.data.status == "rejected")
                        Row(
                          children: [
                            // Label Ditolak (kiri)
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color:
                                      data.data.status == "rejected"
                                          ? Colors.red
                                          : Colors.grey[300],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    "Ditolak",
                                    style: TextStyle(
                                      color:
                                          data.data.status == "rejected"
                                              ? Colors.white
                                              : Colors.black54,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            // Label Setuju (kanan)
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color:
                                      data.data.status == "approved"
                                          ? Colors.green
                                          : Colors.grey[300],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    "Setuju",
                                    style: TextStyle(
                                      color:
                                          data.data.status == "approved"
                                              ? Colors.white
                                              : Colors.black54,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      else
                        SizedBox.shrink(), // disembunyikan kalau bukan approved/rejected

                      if (data.data.status == "rejected") ...[
                        SizedBox(height: 16),

                        // Label
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            "Alasan Ditolak",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),

                        // Container styled like your example
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: TextFormField(
                              controller: TextEditingController(
                                text: data.data.rejectionReason ?? "-",
                              ),
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              decoration: const InputDecoration(
                                hintText: "Alasan Ditolak",
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                              ),
                              readOnly: true,
                              maxLines: null,
                            ),
                          ),
                        ),
                      ],

                      // Text("status: ${data.data.status}"),
                      // Text("alasan ditolak: ${data.data.rejectionReason}"),
                      Divider(color: Colors.grey, thickness: 1),
                      SizedBox(height: 16),

                      Obx(() {
                        if (controller.kondisi.value == "masuk" &&
                            controller.roleId.value == 3 &&
                            data.data.status == "pending") {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: 50, // Ubah tinggi tombol di sini
                                      child: Obx(
                                        () => ElevatedButton(
                                          onPressed: () {
                                            controller.selectedStatus.value =
                                                "rejected";
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                controller
                                                            .selectedStatus
                                                            .value ==
                                                        "rejected"
                                                    ? AppColors.redPastel
                                                    : Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              side: BorderSide(
                                                color: AppColors.redPastel,
                                              ),
                                            ),
                                          ),
                                          child: Text(
                                            "Tolak",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color:
                                                  controller
                                                              .selectedStatus
                                                              .value ==
                                                          "rejected"
                                                      ? Colors.white
                                                      : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: SizedBox(
                                      height: 50, // Ubah tinggi tombol di sini
                                      child: Obx(
                                        () => ElevatedButton(
                                          onPressed: () {
                                            controller.selectedStatus.value =
                                                "approved";
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                controller
                                                            .selectedStatus
                                                            .value ==
                                                        "approved"
                                                    ? Colors.green
                                                    : Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              side: BorderSide(
                                                color: Colors.green,
                                              ),
                                            ),
                                          ),
                                          child: Text(
                                            "Setuju",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color:
                                                  controller
                                                              .selectedStatus
                                                              .value ==
                                                          "approved"
                                                      ? Colors.white
                                                      : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 25),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  "Umpan Balik",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.black.withOpacity(0.2),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  child: TextFormField(
                                    controller: controller.feedbackController,
                                    decoration: const InputDecoration(
                                      hintText: "Ketik Disini",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                      alignLabelWithHint:
                                          true, // Align label with the top-left corner
                                    ),
                                    maxLines: 4,
                                    textAlign:
                                        TextAlign
                                            .start, // Align text to the top-left corner
                                  ),
                                ),
                              ),
                              const SizedBox(height: 50),
                              Column(
                                children: [
                                  if (data.data.status == "pending")
                                    Center(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (controller
                                              .selectedStatus
                                              .value
                                              .isEmpty) {
                                            Get.snackbar(
                                              "Error",
                                              "Silakan pilih status terlebih dahulu (Tolak atau Setuju).",
                                            );
                                            return;
                                          }

                                          controller.submitStatusRequest(
                                            data.data.id,
                                            controller.selectedStatus.value,
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColors.deepOceanBlue,
                                          minimumSize: Size(
                                            double.infinity,
                                            54,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              15,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          "Submit",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          );
                        } else {
                          return SizedBox.shrink(); // Hide the element
                        }
                      }),
                      // Tambahkan field lain sesuai kebutuhan
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        // Cek jika data return tersedia
        if (controller.historyReturnResponse.value != null) {
          final data = controller.historyReturnResponse.value!;
          return Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Dari: ${data.data.coachName}",
                        style: GoogleFonts.poppins(
                          color: Color(0xFF4C4C4C),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          height: 1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Pengajuan Pengembalian Inventaris",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        data.data.landingTanggalPinjam,
                        style: GoogleFonts.poppins(
                          color: AppColors.deepOceanBlue,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Divider(
                        color: Colors.black.withOpacity(0.2),
                        thickness: 1,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      // Text("ID: ${data.data.id}"),
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
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextFormField(
                            controller: TextEditingController(
                              text: data.data.coachName,
                            ),
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
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          "Nama Inventaris",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: AppColors.contrastBlue,
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: TextFormField(
                                  controller: TextEditingController(
                                    text: data.data.inventoryName,
                                  ),
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                  decoration: const InputDecoration(
                                    hintText: "Nama Inventaris",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                  readOnly: true,
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
                                color: AppColors.contrastBlue,
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: TextFormField(
                                  controller: TextEditingController(
                                    text: data.data.qtyReturned.toString(),
                                  ),
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                  decoration: const InputDecoration(
                                    hintText: "Qty",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                  readOnly: true,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
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
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextFormField(
                            controller: TextEditingController(
                              text: data.data.mastercoachName,
                            ),
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            decoration: const InputDecoration(
                              hintText: "Nama Master Coach",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),

                            readOnly: true,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          "Tanggal Pinjam",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextFormField(
                            controller: TextEditingController(
                              text: data.data.landingTanggalPinjam,
                            ),
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            decoration: const InputDecoration(
                              hintText: "Tanggal Pinjam",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),

                            readOnly: true,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          "Tanggal Kembali",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextFormField(
                            controller: TextEditingController(
                              text: data.data.landingTanggalKembali,
                            ),
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            decoration: const InputDecoration(
                              hintText: "Tanggal Kembali",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),

                            readOnly: true,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          "Alasan Pinjam",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.black.withOpacity(0.2),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: TextFormField(
                            controller: TextEditingController(
                              text: data.data.landingAlasanPinjam,
                            ),
                            decoration: const InputDecoration(
                              hintText: "Ketik Disini",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                              alignLabelWithHint:
                                  true, // Align label with the top-left corner
                            ),
                            maxLines: 3,
                            textAlign:
                                TextAlign
                                    .start, // Align text to the top-left corner
                            readOnly: true, // Make the field read-only
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      if (data.data.status == "approved" ||
                          data.data.status == "rejected")
                        Row(
                          children: [
                            // Label Ditolak (kiri)
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color:
                                      data.data.status == "rejected"
                                          ? Colors.red
                                          : Colors.grey[300],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    "Ditolak",
                                    style: TextStyle(
                                      color:
                                          data.data.status == "rejected"
                                              ? Colors.white
                                              : Colors.black54,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            // Label Setuju (kanan)
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color:
                                      data.data.status == "approved"
                                          ? Colors.green
                                          : Colors.grey[300],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    "Setuju",
                                    style: TextStyle(
                                      color:
                                          data.data.status == "approved"
                                              ? Colors.white
                                              : Colors.black54,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      else
                        SizedBox.shrink(), // disembunyikan kalau bukan approved/rejected

                      if (data.data.status == "rejected") ...[
                        SizedBox(height: 16),

                        // Label
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            "Alasan Ditolak",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),

                        // Container styled like your example
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: TextFormField(
                              controller: TextEditingController(
                                text: data.data.rejectionReason ?? "-",
                              ),
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              decoration: const InputDecoration(
                                hintText: "Alasan Ditolak",
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                              ),
                              readOnly: true,
                              maxLines: null,
                            ),
                          ),
                        ),
                      ],

                      // Text("status: ${data.data.status}"),
                      // Text("alasan ditolak: ${data.data.rejectionReason}"),
                      Divider(color: Colors.grey, thickness: 1),
                      SizedBox(height: 16),
                      Obx(() {
                        if (controller.kondisi.value == "masuk" &&
                            controller.roleId.value == 3 &&
                            data.data.status == "pending") {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: 50, // Ubah tinggi tombol di sini
                                      child: Obx(
                                        () => ElevatedButton(
                                          onPressed: () {
                                            controller.selectedStatus.value =
                                                "rejected";
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                controller
                                                            .selectedStatus
                                                            .value ==
                                                        "rejected"
                                                    ? AppColors.redPastel
                                                    : Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              side: BorderSide(
                                                color: AppColors.redPastel,
                                              ),
                                            ),
                                          ),
                                          child: Text(
                                            "Tolak",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color:
                                                  controller
                                                              .selectedStatus
                                                              .value ==
                                                          "rejected"
                                                      ? Colors.white
                                                      : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: SizedBox(
                                      height: 50, // Ubah tinggi tombol di sini
                                      child: Obx(
                                        () => ElevatedButton(
                                          onPressed: () {
                                            controller.selectedStatus.value =
                                                "approved";
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                controller
                                                            .selectedStatus
                                                            .value ==
                                                        "approved"
                                                    ? Colors.green
                                                    : Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              side: BorderSide(
                                                color: Colors.green,
                                              ),
                                            ),
                                          ),
                                          child: Text(
                                            "Setuju",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color:
                                                  controller
                                                              .selectedStatus
                                                              .value ==
                                                          "approved"
                                                      ? Colors.white
                                                      : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 25),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  "Umpan Balik",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.black.withOpacity(0.2),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  child: TextFormField(
                                    controller: controller.feedbackController,
                                    decoration: const InputDecoration(
                                      hintText: "Ketik Disini",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                      alignLabelWithHint:
                                          true, // Align label with the top-left corner
                                    ),
                                    maxLines: 4,
                                    textAlign:
                                        TextAlign
                                            .start, // Align text to the top-left corner
                                  ),
                                ),
                              ),
                              const SizedBox(height: 50),
                              if (data.data.status == "pending")
                                Center(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (controller
                                          .selectedStatus
                                          .value
                                          .isEmpty) {
                                        Get.snackbar(
                                          "Error",
                                          "Silakan pilih status terlebih dahulu (Tolak atau Setuju).",
                                        );
                                        return;
                                      }

                                      controller.submitStatusReturn(
                                        data.data.id,
                                        controller.selectedStatus.value,
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.deepOceanBlue,
                                      minimumSize: Size(double.infinity, 54),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    child: Text(
                                      "Submit",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          );
                        } else {
                          return SizedBox.shrink(); // Hide the element
                        }
                      }),
                      // Tambahkan field lain sesuai kebutuhan
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        // Jika data tidak tersedia
        return const Center(child: Text("Data tidak ditemukan."));
      }),
    );
  }
}
