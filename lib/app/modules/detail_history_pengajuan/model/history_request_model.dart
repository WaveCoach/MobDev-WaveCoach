class InventoryRequest {
  final int id;
  final String status;
  final String tanggalPinjam;
  final String tanggalKembali;
  final String alasanPinjam;
  final int mastercoachId;
  final String mastercoachName;
  final int coachId;
  final String coachName;
  final List<InventoryItem> items;

  InventoryRequest({
    required this.id,
    required this.status,
    required this.tanggalPinjam,
    required this.tanggalKembali,
    required this.alasanPinjam,
    required this.mastercoachId,
    required this.mastercoachName,
    required this.coachId,
    required this.coachName,
    required this.items,
  });

  factory InventoryRequest.fromJson(Map<String, dynamic> json) {
    return InventoryRequest(
      id: json['id'] ?? 0,
      status: json['status'] ?? '',
      tanggalPinjam: json['tanggal_pinjam'] ?? '',
      tanggalKembali: json['tanggal_kembali'] ?? '',
      alasanPinjam: json['alasan_pinjam'] ?? '',
      mastercoachId: json['mastercoach_id'] ?? 0,
      mastercoachName: json['mastercoach_name'] ?? '',
      coachId: json['coach_id'] ?? 0,
      coachName: json['coach_name'] ?? '',
      items:
          (json['items'] as List? ?? [])
              .map((item) => InventoryItem.fromJson(item))
              .toList(),
    );
  }
}

class InventoryItem {
  final int inventoryId;
  final String inventoryName;
  final int qtyRequested;

  InventoryItem({
    required this.inventoryId,
    required this.inventoryName,
    required this.qtyRequested,
  });

  factory InventoryItem.fromJson(Map<String, dynamic> json) {
    return InventoryItem(
      inventoryId: json['inventory_id'] ?? 0,
      inventoryName: json['inventory_name'] ?? '',
      qtyRequested: json['qty_requested'] ?? 0,
    );
  }
}
