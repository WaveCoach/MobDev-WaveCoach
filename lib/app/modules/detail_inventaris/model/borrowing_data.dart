class BorrowingData {
  final String type;
  final int id;
  final String createdAt;
  final String status;
  final int qty;
  final String? tanggalPinjam;
  final String? tanggalKembali;
  final String? returnedAt;
  final int? damagedCount;
  final int? missingCount;
  final String? imgInventoryReturn;
  final String? rejectionReason;
  final String? desc;
  final String coachName;
  final String mastercoachName;
  final String inventoryName;

  BorrowingData({
    required this.type,
    required this.id,
    required this.createdAt,
    required this.status,
    required this.qty,
    this.tanggalPinjam,
    this.tanggalKembali,
    this.returnedAt,
    this.damagedCount,
    this.missingCount,
    this.imgInventoryReturn,
    this.rejectionReason,
    this.desc,
    required this.coachName,
    required this.mastercoachName,
    required this.inventoryName,
  });

  factory BorrowingData.fromJson(Map<String, dynamic> json) {
    return BorrowingData(
      type: json['type'],
      id: json['id'],
      createdAt: json['created_at'],
      status: json['status'],
      qty: json['qty'],
      tanggalPinjam: json['tanggal_pinjam'],
      tanggalKembali: json['tanggal_kembali'],
      returnedAt: json['returned_at'],
      damagedCount: json['damaged_count'],
      missingCount: json['missing_count'],
      imgInventoryReturn: json['img_inventory_return'],
      rejectionReason: json['rejection_reason'],
      desc: json['desc'],
      coachName: json['coach_name'],
      mastercoachName: json['mastercoach_name'],
      inventoryName: json['inventory_name'],
    );
  }
}
