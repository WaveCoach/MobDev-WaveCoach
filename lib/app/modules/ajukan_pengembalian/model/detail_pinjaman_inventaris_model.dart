class InventoryLandingDetail {
  final int id;
  final int coachId;
  final String coachName;
  final int mastercoachId;
  final String mastercoachName;
  final String tanggalPinjam;
  final int inventoryId;
  final String inventoryName;
  final int? qtyBorrow;

  InventoryLandingDetail({
    required this.id,
    required this.coachId,
    required this.coachName,
    required this.mastercoachId,
    required this.mastercoachName,
    required this.tanggalPinjam,
    required this.inventoryId,
    required this.inventoryName,
    required this.qtyBorrow,
  });

  factory InventoryLandingDetail.fromJson(Map<String, dynamic> json) {
    return InventoryLandingDetail(
      id: json['id'],
      coachId: json['coach_id'],
      coachName: json['coach_name'],
      mastercoachId: json['mastercoach_id'],
      mastercoachName: json['mastercoach_name'],
      tanggalPinjam: json['tanggal_pinjam'],
      inventoryId: json['inventory_id'],
      inventoryName: json['inventory_name'],
      qtyBorrow: json['qty_borrowed'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'coach_id': coachId,
      'coach_name': coachName,
      'mastercoach_id': mastercoachId,
      'mastercoach_name': mastercoachName,
      'tanggal_pinjam': tanggalPinjam,
      'inventory_id': inventoryId,
      'inventory_name': inventoryName,
      'qty_borrow': qtyBorrow,
    };
  }
}
