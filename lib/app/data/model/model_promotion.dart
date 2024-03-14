class ModelPromotion {
  int? status;
  String? message;
  Data? data;

  ModelPromotion({this.status, this.message, this.data});

  ModelPromotion.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Docs>? docs;
  int? totalDocs;
  int? limit;
  int? totalPages;
  int? page;
  int? pagingCounter;
  bool? hasPrevPage;
  bool? hasNextPage;
  Null? prevPage;
  Null? nextPage;

  Data({this.docs, this.totalDocs, this.limit, this.totalPages, this.page, this.pagingCounter, this.hasPrevPage, this.hasNextPage, this.prevPage, this.nextPage});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['docs'] != null) {
      docs = <Docs>[];
      json['docs'].forEach((v) {
        docs!.add(new Docs.fromJson(v));
      });
    }
    totalDocs = json['totalDocs'];
    limit = json['limit'];
    totalPages = json['totalPages'];
    page = json['page'];
    pagingCounter = json['pagingCounter'];
    hasPrevPage = json['hasPrevPage'];
    hasNextPage = json['hasNextPage'];
    prevPage = json['prevPage'];
    nextPage = json['nextPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.docs != null) {
      data['docs'] = this.docs!.map((v) => v.toJson()).toList();
    }
    data['totalDocs'] = this.totalDocs;
    data['limit'] = this.limit;
    data['totalPages'] = this.totalPages;
    data['page'] = this.page;
    data['pagingCounter'] = this.pagingCounter;
    data['hasPrevPage'] = this.hasPrevPage;
    data['hasNextPage'] = this.hasNextPage;
    data['prevPage'] = this.prevPage;
    data['nextPage'] = this.nextPage;
    return data;
  }
}

class Docs {
  String? sId;
  String? title;
  Product? product;
  String? image;
  String? imageId;
  String? description;
  bool? isActive;
  String? startDate;
  String? endDate;
  String? date;
  int? iV;

  Docs({this.sId, this.title, this.product, this.image, this.imageId, this.description, this.isActive, this.startDate, this.endDate, this.date, this.iV});

  Docs.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    product = json['product'] != null ? new Product.fromJson(json['product']) : null;
    image = json['image'];
    imageId = json['imageId'];
    description = json['description'];
    isActive = json['isActive'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    date = json['date'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['image'] = this.image;
    data['imageId'] = this.imageId;
    data['description'] = this.description;
    data['isActive'] = this.isActive;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['date'] = this.date;
    data['__v'] = this.iV;
    return data;
  }
}

class Product {
  String? sId;
  String? name;

  Product({this.sId, this.name});

  Product.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    return data;
  }
}
