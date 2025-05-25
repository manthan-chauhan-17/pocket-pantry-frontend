class ItemModel {
  int? statusCode;
  List<Data>? data;
  String? message;
  bool? success;

  ItemModel({this.statusCode, this.data, this.message, this.success});

  ItemModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class Data {
  String? sId;
  String? itemName;
  String? itemDescription;
  String? expireDate;
  String? category;
  String? user;
  int? iV;
  String? image;

  Data(
      {this.sId,
      this.itemName,
      this.itemDescription,
      this.expireDate,
      this.category,
      this.user,
      this.iV,
      this.image});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    itemName = json['itemName'];
    itemDescription = json['itemDescription'];
    expireDate = json['expireDate'];
    category = json['category'];
    user = json['user'];
    iV = json['__v'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['itemName'] = this.itemName;
    data['itemDescription'] = this.itemDescription;
    data['expireDate'] = this.expireDate;
    data['category'] = this.category;
    data['user'] = this.user;
    data['__v'] = this.iV;
    data['image'] = this.image;
    return data;
  }
}
