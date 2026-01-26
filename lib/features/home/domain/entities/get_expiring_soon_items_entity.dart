class GetExpiringSoonItemsEntity {
  final int? statusCode;
  final String? message;
  final bool? success;
  final List<ExpiringSoonItemEntity>? expiringSoonItems;

  const GetExpiringSoonItemsEntity({
    this.statusCode,
    this.message,
    this.success,
    this.expiringSoonItems,
  });
}

class ExpiringSoonItemEntity {
  final ItemImageEntity? image;
  final QuantityEntity? quantity;
  final LowStockThresholdEntity? lowStockThreshold;
  final String? id;
  final String? itemName;
  final String? itemDescription;
  final int? expireDate;
  final String? category;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ExpiringSoonItemEntity({
    this.image,
    this.quantity,
    this.lowStockThreshold,
    this.id,
    this.itemName,
    this.itemDescription,
    this.expireDate,
    this.category,
    this.createdAt,
    this.updatedAt,
  });
}

class ItemImageEntity {
  final String? url;
  final String? publicId;

  const ItemImageEntity({this.url, this.publicId});
}

class QuantityEntity {
  final int? value;
  final String? unit;

  const QuantityEntity({this.value, this.unit});
}

class LowStockThresholdEntity {
  final int? value;
  final String? unit;

  const LowStockThresholdEntity({this.value, this.unit});
}
