class StockListModel {
  final int mastercoachId;
  final String mastercoachName;
  final String? mastercoachImageUrl;
  final List<StockItem> items;

  StockListModel({
    required this.mastercoachId,
    required this.mastercoachName,
    this.mastercoachImageUrl,
    required this.items,
  });

  factory StockListModel.fromJson(Map<String, dynamic> json) {
    return StockListModel(
      mastercoachId: json['mastercoach_id'] ?? 0,
      mastercoachName: json['mastercoach_name'] ?? '',
      mastercoachImageUrl: json['mastercoach_profile'] ?? null,
      items:
          (json['items'] as List?)
              ?.map((x) => StockItem.fromJson(x))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mastercoach_id': mastercoachId,
      'mastercoach_name': mastercoachName,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}

class StockItem {
  final int inventoryId;
  final String inventoryName;
  final int totalQty;

  StockItem({
    required this.inventoryId,
    required this.inventoryName,
    required this.totalQty,
  });

  factory StockItem.fromJson(Map<String, dynamic> json) {
    return StockItem(
      inventoryId: json['inventory_id'] ?? 0,
      inventoryName: json['inventory_name'] ?? '',
      totalQty:
          (json['total_qty'] is int)
              ? json['total_qty']
              : int.tryParse(json['total_qty'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'inventory_id': inventoryId,
      'inventory_name': inventoryName,
      'total_qty': totalQty,
    };
  }
}
