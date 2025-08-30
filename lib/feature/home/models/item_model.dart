class ItemModel {
  int? statusCode;
  String? message;
  bool? success;
  List<Items>? items;

  ItemModel({this.statusCode, this.message, this.success, this.items});

  ItemModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    success = json['success'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    data['success'] = this.success;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  Image? image;
  String? itemName;
  String? itemDescription;
  int? expireDate;
  String? category;
  String? createdAt;
  String? updatedAt;
  String? id;

  Items(
      {this.image,
      this.itemName,
      this.itemDescription,
      this.expireDate,
      this.category,
      this.createdAt,
      this.updatedAt,
      this.id});

  Items.fromJson(Map<String, dynamic> json) {
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    itemName = json['itemName'];
    itemDescription = json['itemDescription'];
    expireDate = json['expireDate'];
    category = json['category'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    data['itemName'] = this.itemName;
    data['itemDescription'] = this.itemDescription;
    data['expireDate'] = this.expireDate;
    data['category'] = this.category;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
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
