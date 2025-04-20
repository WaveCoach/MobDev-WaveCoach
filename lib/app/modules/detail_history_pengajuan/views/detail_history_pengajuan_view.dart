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

                      // Text("status: ${data.data.status}"),
                      // Text("alasan ditolak: ${data.data.rejectionReason}"),
                      Divider(color: Colors.grey, thickness: 1),
                      SizedBox(height: 16),
                      Obx(() {
                        if (controller.Type.value == "request" &&
                            controller.roleId.value == 3) {
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

                      // Text("status: ${data.data.status}"),
                      // Text("alasan ditolak: ${data.data.rejectionReason}"),
                      Divider(color: Colors.grey, thickness: 1),
                      SizedBox(height: 16),
                      Obx(() {
                        if (controller.Type.value == "return" &&
                            controller.roleId.value == 3) {
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
