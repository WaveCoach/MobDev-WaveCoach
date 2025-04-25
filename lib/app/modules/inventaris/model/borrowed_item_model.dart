class BorrowedItem {
  final int inventoryId;
  final String name;
  final String totalQtyBorrowed;
  final String totalQtyReturned;
  final String totalQtyRemaining;
  final String? image;
  final String? imageUrl;

  BorrowedItem({
    required this.inventoryId,
    required this.name,
    required this.totalQtyBorrowed,
    required this.totalQtyReturned,
    required this.totalQtyRemaining,
    this.image,
    this.imageUrl,
  });

  factory BorrowedItem.fromJson(Map<String, dynamic> json) {
    return BorrowedItem(
      inventoryId: json['inventory_id'],
      name: json['name'] ?? '',
      totalQtyBorrowed: json['total_qty_borrowed']?.toString() ?? '0',
      totalQtyReturned: json['total_qty_returned']?.toString() ?? '0',
      totalQtyRemaining: json['total_qty_remaining']?.toString() ?? '0',
      image: json['inventory_image'],
      imageUrl: json['inventory_image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'inventory_id': inventoryId,
      'name': name,
      'total_qty_borrowed': totalQtyBorrowed,
      'total_qty_returned': totalQtyReturned,
      'total_qty_remaining': totalQtyRemaining,
      'inventory_image': image,
      'inventory_image_url': imageUrl,
    };
  }
}
