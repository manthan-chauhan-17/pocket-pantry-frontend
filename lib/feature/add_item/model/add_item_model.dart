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
    item = json['item'] != null ? new Item.fromJson(json['item']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    data['success'] = this.success;
    if (this.item != null) {
      data['item'] = this.item!.toJson();
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
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['itemName'] = this.itemName;
    data['itemDescription'] = this.itemDescription;
    data['expireDate'] = this.expireDate;
    data['category'] = this.category;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['publicId'] = this.publicId;
    return data;
  }
}
