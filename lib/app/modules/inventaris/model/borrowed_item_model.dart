class BorrowedItem {
  final int inventoryId;
  final String name;
  final String totalQtyBorrowed;

  BorrowedItem({
    required this.inventoryId,
    required this.name,
    required this.totalQtyBorrowed,
  });

  factory BorrowedItem.fromJson(Map<String, dynamic> json) {
    return BorrowedItem(
      inventoryId: json['inventory_id'],
      name: json['name'],
      totalQtyBorrowed: json['total_qty_borrowed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'inventory_id': inventoryId,
      'name': name,
      'total_qty_borrowed': totalQtyBorrowed,
    };
  }
}
