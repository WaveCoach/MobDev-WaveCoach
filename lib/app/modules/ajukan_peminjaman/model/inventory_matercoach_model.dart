class InventoryItem {
  final int id;
  final int mastercoachId;
  final int inventoryId;
  final int qty;
  final String mastercoachName;
  final String inventoryName;

  InventoryItem({
    required this.id,
    required this.mastercoachId,
    required this.inventoryId,
    required this.qty,
    required this.mastercoachName,
    required this.inventoryName,
  });

  factory InventoryItem.fromJson(Map<String, dynamic> json) {
    return InventoryItem(
      id: json['id'] as int,
      mastercoachId: json['mastercoach_id'] as int,
      inventoryId: json['inventory_id'] as int,
      qty: json['qty'] as int,
      mastercoachName: json['mastercoach_name'] as String,
      inventoryName: json['inventory_name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'mastercoach_id': mastercoachId,
      'inventory_id': inventoryId,
      'qty': qty,
      'mastercoach_name': mastercoachName,
      'inventory_name': inventoryName,
    };
  }
}
