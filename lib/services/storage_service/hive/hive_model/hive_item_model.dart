import 'package:hive/hive.dart';

part 'hive_item_model.g.dart';

@HiveType(typeId: 0)
class HiveItemModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String itemName;

  @HiveField(2)
  final String itemDescription;

  @HiveField(3)
  final String expireDate;

  @HiveField(4)
  final String category;

  @HiveField(5)
  final String imageUrl;

  @HiveField(6)
  final String imagePublicId;

  HiveItemModel({
    required this.id,
    required this.itemName,
    required this.itemDescription,
    required this.expireDate,
    required this.category,
    required this.imageUrl,
    required this.imagePublicId,
  });

  // Factory method to create from API JSON
  factory HiveItemModel.fromJson(Map<String, dynamic> json) {
    return HiveItemModel(
      id: json['_id'],
      itemName: json['itemName'],
      itemDescription: json['itemDescription'],
      expireDate: json['expireDate'],
      category: json['category'],
      imageUrl: json['image']['url'],
      imagePublicId: json['image']['publicId'],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "itemName": itemName,
        "itemDescription": itemDescription,
        "expireDate": expireDate,
        "category": category,
        "image": {
          "url": imageUrl,
          "publicId": imagePublicId,
        }
      };
}
