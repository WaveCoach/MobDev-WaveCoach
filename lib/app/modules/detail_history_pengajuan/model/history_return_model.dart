class InventoryReturn {
  final int id;
  final String status;
  final int qtyReturned;
  final String returnedAt;
  final int inventoryId;
  final String inventoryName;
  final int mastercoachId;
  final String mastercoachName;
  final int coachId;
  final String coachName;
  final int landingId;
  final String landingTanggalPinjam;
  final String landingTanggalKembali;
  final String? landingAlasanPinjam;
  final int requestId;
  final String requestTanggalPinjam;
  final String requestTanggalKembali;

  InventoryReturn({
    required this.id,
    required this.status,
    required this.qtyReturned,
    required this.returnedAt,
    required this.inventoryId,
    required this.inventoryName,
    required this.mastercoachId,
    required this.mastercoachName,
    required this.coachId,
    required this.coachName,
    required this.landingId,
    required this.landingTanggalPinjam,
    required this.landingTanggalKembali,
    this.landingAlasanPinjam,
    required this.requestId,
    required this.requestTanggalPinjam,
    required this.requestTanggalKembali,
  });

  factory InventoryReturn.fromJson(Map<String, dynamic> json) {
    return InventoryReturn(
      id: json['id'] ?? 0,
      status: json['status'] ?? '',
      qtyReturned: json['qty_returned'] ?? 0,
      returnedAt: json['returned_at'] ?? '',
      inventoryId: json['inventory_id'] ?? 0,
      inventoryName: json['inventory_name'] ?? '',
      mastercoachId: json['mastercoach_id'] ?? 0,
      mastercoachName: json['mastercoach_name'] ?? '',
      coachId: json['coach_id'] ?? 0,
      coachName: json['coach_name'] ?? '',
      landingId: json['landing_id'] ?? 0,
      landingTanggalPinjam: json['landing_tanggal_pinjam'] ?? '',
      landingTanggalKembali: json['landing_tanggal_kembali'] ?? '',
      landingAlasanPinjam:
          json['landing_alasan_pinjam'], // nullable, tidak perlu ??
      requestId: json['request_id'] ?? 0,
      requestTanggalPinjam: json['request_tanggal_pinjam'] ?? '',
      requestTanggalKembali: json['request_tanggal_kembali'] ?? '',
    );
  }
}
