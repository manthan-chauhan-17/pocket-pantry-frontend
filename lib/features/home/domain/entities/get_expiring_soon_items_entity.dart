class GetExpiringSoonItemsEntity {
  final int? statusCode;
  final String? message;
  final bool? success;
  final List<ExpiringSoonItemEntity>? items;
  final ExpiringSoonMetaEntity? meta;

  const GetExpiringSoonItemsEntity({
    this.statusCode,
    this.message,
    this.success,
    this.items,
    this.meta,
  });
}

class ExpiringSoonItemEntity {
  final String? itemId;
  final String? name;
  final int? expireDate;
  final ExpiringSoonQuantityEntity? quantity;
  final ExpiringSoonLowStockThresholdEntity? lowStockThreshold;
  final String? category;
  final String? imageUrl;
  final DateTime? createdAt;

  const ExpiringSoonItemEntity({
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

class ExpiringSoonQuantityEntity {
  final int? value;
  final String? unit;

  const ExpiringSoonQuantityEntity({this.value, this.unit});
}

class ExpiringSoonLowStockThresholdEntity {
  final int? value;
  final String? unit;

  const ExpiringSoonLowStockThresholdEntity({this.value, this.unit});
}

class ExpiringSoonMetaEntity {
  final int? total;

  const ExpiringSoonMetaEntity({this.total});
}
