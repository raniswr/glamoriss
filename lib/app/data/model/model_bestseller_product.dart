class ModelBestSellerProduct {
  int? status;
  String? message;
  List<Data>? data;

  ModelBestSellerProduct({this.status, this.message, this.data});

  ModelBestSellerProduct.fromJson(Map<String, dynamic> json) {
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
  String? filter;
  List<Product>? product;

  Data({this.filter, this.product});

  Data.fromJson(Map<String, dynamic> json) {
    filter = json['filter'];
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product!.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['filter'] = this.filter;
    if (this.product != null) {
      data['product'] = this.product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  String? sId;
  String? name;
  int? sales;
  int? price;
  String? image;

  Product({this.sId, this.name, this.sales, this.price, this.image});

  Product.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    sales = json['sales'];
    price = json['price'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['sales'] = this.sales;
    data['price'] = this.price;
    data['image'] = this.image;
    return data;
  }
}
