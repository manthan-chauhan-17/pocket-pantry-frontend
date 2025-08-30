class AddItemModel {
  int? statusCode;
  String? message;
  bool? success;
  Item? item;

  AddItemModel({this.statusCode, this.message, this.success, this.item});

  AddItemModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    success = json['success'];
    item = json['item'] != null ? Item.fromJson(json['item']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    data['success'] = success;
    if (item != null) {
      data['item'] = item!.toJson();
    }
    return data;
  }
}

class Item {
  String? id;
  String? itemName;
  String? itemDescription;
  String? expireDate;
  String? category;
  Image? image;

  Item(
      {this.id,
      this.itemName,
      this.itemDescription,
      this.expireDate,
      this.category,
      this.image});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemName = json['itemName'];
    itemDescription = json['itemDescription'];
    expireDate = json['expireDate'];
    category = json['category'];
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['itemName'] = itemName;
    data['itemDescription'] = itemDescription;
    data['expireDate'] = expireDate;
    data['category'] = category;
    if (image != null) {
      data['image'] = image!.toJson();
    }
    return data;
  }
}

class Image {
  String? url;
  String? publicId;

  Image({this.url, this.publicId});

  Image.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    publicId = json['publicId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['publicId'] = publicId;
    return data;
  }
}
