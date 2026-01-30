class GetItemsEntity {
  final int? statusCode;
  final String? message;
  final bool? success;
  final List<ItemEntity>? items;
  final MetaEntity? meta;

  const GetItemsEntity({
    this.statusCode,
    this.message,
    this.success,
    this.items,
    this.meta,
  });
}

class ItemEntity {
  final String? itemId;
  final String? name;
  final int? expireDate;
  final QuantityEntity? quantity;
  final LowStockThresholdEntity? lowStockThreshold;
  final String? category;
  final String? imageUrl;
  final DateTime? createdAt;

  const ItemEntity({
    this.itemId,
    this.name,
    this.expireDate,
    this.quantity,
    this.lowStockThreshold,
    this.category,
    this.imageUrl,
    this.createdAt,
  });
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

class MetaEntity {
  final int? total;

  const MetaEntity({this.total});
}
