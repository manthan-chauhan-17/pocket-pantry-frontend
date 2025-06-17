class ItemModel {
  int? statusCode;
  String? message;
  bool? success;
  List<Item>? item;

  ItemModel({this.statusCode, this.message, this.success, this.item});

  ItemModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    success = json['success'];
    if (json['item'] != null) {
      item = <Item>[];
      json['item'].forEach((v) {
        item!.add(new Item.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    data['success'] = this.success;
    if (this.item != null) {
      data['item'] = this.item!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Item {
  Image? image;
  String? sId;
  String? itemName;
  String? itemDescription;
  String? expireDate;
  String? category;
  String? user;
  int? iV;

  Item(
      {this.image,
      this.sId,
      this.itemName,
      this.itemDescription,
      this.expireDate,
      this.category,
      this.user,
      this.iV});

  Item.fromJson(Map<String, dynamic> json) {
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    sId = json['_id'];
    itemName = json['itemName'];
    itemDescription = json['itemDescription'];
    expireDate = json['expireDate'];
    category = json['category'];
    user = json['user'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    data['_id'] = this.sId;
    data['itemName'] = this.itemName;
    data['itemDescription'] = this.itemDescription;
    data['expireDate'] = this.expireDate;
    data['category'] = this.category;
    data['user'] = this.user;
    data['__v'] = this.iV;
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
