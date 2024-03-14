class ModelGetAllProduct {
  int? status;
  String? message;
  List<Data>? data;

  ModelGetAllProduct({this.status, this.message, this.data});

  ModelGetAllProduct.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? name;
  String? image;
  String? imageId;
  int? price;
  String? description;
  bool? isAvailable;
  int? stock;
  int? point;
  String? date;
  int? iV;
  String? branch;
  String? shopee;
  String? tokped;

  Data({this.sId, this.name, this.image, this.imageId, this.price, this.description, this.isAvailable, this.stock, this.point, this.date, this.iV, this.branch, this.shopee, this.tokped});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    image = json['image'];
    imageId = json['imageId'];
    price = json['price'];
    description = json['description'];
    isAvailable = json['isAvailable'];
    stock = json['stock'];
    point = json['point'];
    date = json['date'];
    iV = json['__v'];
    branch = json['branch'];
    shopee = json['shopee'];
    tokped = json['tokped'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['imageId'] = this.imageId;
    data['price'] = this.price;
    data['description'] = this.description;
    data['isAvailable'] = this.isAvailable;
    data['stock'] = this.stock;
    data['point'] = this.point;
    data['date'] = this.date;
    data['__v'] = this.iV;
    data['branch'] = this.branch;
    data['shopee'] = this.shopee;
    data['tokped'] = this.tokped;
    return data;
  }
}
