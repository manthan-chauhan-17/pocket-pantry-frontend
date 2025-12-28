class GetItemsEntity {
  final int? statusCode;
  final String? message;
  final bool? success;
  final List<ItemEntity>? items;

  const GetItemsEntity({
    this.statusCode,
    this.message,
    this.success,
    this.items,
  });
}

class ItemEntity {
  final ItemImageEntity? image;
  final String? itemName;
  final String? itemDescription;
  final int? expireDate;
  final String? category;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? id;

  const ItemEntity({
    this.image,
    this.itemName,
    this.itemDescription,
    this.expireDate,
    this.category,
    this.createdAt,
    this.updatedAt,
    this.id,
  });
}

class ItemImageEntity {
  final String? url;
  final String? publicId;

  const ItemImageEntity({this.url, this.publicId});
}
