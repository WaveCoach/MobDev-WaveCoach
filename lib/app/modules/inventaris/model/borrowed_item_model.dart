class BorrowedItem {
  final int inventoryId;
  final String name;
  final String totalQtyBorrowed;
  final String? imageUrl;

  BorrowedItem({
    required this.inventoryId,
    required this.name,
    required this.totalQtyBorrowed,
    this.imageUrl,
  });

  factory BorrowedItem.fromJson(Map<String, dynamic> json) {
    return BorrowedItem(
      inventoryId: json['inventory_id'],
      name: json['name'],
      totalQtyBorrowed: json['total_qty_borrowed'],
      imageUrl: json['inventory_image_url'] ?? null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'inventory_id': inventoryId,
      'name': name,
      'total_qty_borrowed': totalQtyBorrowed,
      'inventory_image_url': imageUrl,
    };
  }
}
