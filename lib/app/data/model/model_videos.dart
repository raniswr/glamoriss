class ModelVideo {
  int? status;
  String? message;
  List<Data>? data;

  ModelVideo({this.status, this.message, this.data});

  ModelVideo.fromJson(Map<String, dynamic> json) {
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
  Product? product;
  String? videoUrl;
  bool? isActive;
  String? date;
  int? iV;
  String? title;
  String? description;

  Data({this.sId, this.product, this.videoUrl, this.isActive, this.date, this.iV, this.title, this.description});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    product = json['product'] != null ? new Product.fromJson(json['product']) : null;
    videoUrl = json['videoUrl'];
    isActive = json['isActive'];
    date = json['date'];
    iV = json['__v'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['videoUrl'] = this.videoUrl;
    data['isActive'] = this.isActive;
    data['date'] = this.date;
    data['__v'] = this.iV;
    data['title'] = this.title;
    data['description'] = this.description;
    return data;
  }
}

class Product {
  String? sId;
  String? name;
  String? image;
  int? price;

  Product({this.sId, this.name, this.image, this.price});

  Product.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    image = json['image'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['price'] = this.price;
    return data;
  }
}
