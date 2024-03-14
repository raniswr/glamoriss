class ModelRedeem {
  int? status;
  String? message;
  Data? data;

  ModelRedeem({this.status, this.message, this.data});

  ModelRedeem.fromJson(Map<String, dynamic> json) {
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
  String? rewardId;
  String? startDate;
  String? dueDate;
  String? name;
  Null? product;
  Null? treatment;
  String? image;
  String? imageId;
  String? description;
  bool? isActive;
  int? point;
  String? date;
  int? iV;
  int? discount;
  int? discountPrice;
  List<String>? memberLevel;

  Docs(
      {this.sId,
      this.rewardId,
      this.startDate,
      this.dueDate,
      this.name,
      this.product,
      this.treatment,
      this.image,
      this.imageId,
      this.description,
      this.isActive,
      this.point,
      this.date,
      this.iV,
      this.discount,
      this.discountPrice,
      this.memberLevel});

  Docs.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    rewardId = json['rewardId'];
    startDate = json['startDate'];
    dueDate = json['dueDate'];
    name = json['name'];
    product = json['product'];
    treatment = json['treatment'];
    image = json['image'];
    imageId = json['imageId'];
    description = json['description'];
    isActive = json['isActive'];
    point = json['point'];
    date = json['date'];
    iV = json['__v'];
    discount = json['discount'];
    discountPrice = json['discountPrice'];
    memberLevel = json['memberLevel'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['rewardId'] = this.rewardId;
    data['startDate'] = this.startDate;
    data['dueDate'] = this.dueDate;
    data['name'] = this.name;
    data['product'] = this.product;
    data['treatment'] = this.treatment;
    data['image'] = this.image;
    data['imageId'] = this.imageId;
    data['description'] = this.description;
    data['isActive'] = this.isActive;
    data['point'] = this.point;
    data['date'] = this.date;
    data['__v'] = this.iV;
    data['discount'] = this.discount;
    data['discountPrice'] = this.discountPrice;
    data['memberLevel'] = this.memberLevel;
    return data;
  }
}
