class BorrowingData {
  final int id;
  final String tanggalPinjam;
  final String tanggalKembali;
  final String status;
  final int qtyOut;
  final String coachName;
  final String mastercoachName;
  final String inventoryName;

  BorrowingData({
    required this.id,
    required this.tanggalPinjam,
    required this.tanggalKembali,
    required this.status,
    required this.qtyOut,
    required this.coachName,
    required this.mastercoachName,
    required this.inventoryName,
  });

  factory BorrowingData.fromJson(Map<String, dynamic> json) {
    return BorrowingData(
      id: json['id'],
      tanggalPinjam: json['tanggal_pinjam'],
      tanggalKembali: json['tanggal_kembali'],
      status: json['status'],
      qtyOut: json['qty_borrowed'],
      coachName: json['coach_name'],
      mastercoachName: json['mastercoach_name'],
      inventoryName: json['inventory_name'],
    );
  }
}
