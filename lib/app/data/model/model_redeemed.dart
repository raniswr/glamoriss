class ModelRedeemed {
  int? status;
  String? message;
  Data? data;

  ModelRedeemed({this.status, this.message, this.data});

  ModelRedeemed.fromJson(Map<String, dynamic> json) {
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
  List<DocsVoucher>? docs;
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
      docs = <DocsVoucher>[];
      json['docs'].forEach((v) {
        docs!.add(new DocsVoucher.fromJson(v));
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

class DocsVoucher {
  String? sId;
  String? voucherId;
  Member? member;
  String? reward;
  String? name;
  int? discount;
  int? discountPrice;
  String? startDate;
  bool? isUsed;
  String? date;
  int? iV;

  DocsVoucher({this.sId, this.voucherId, this.member, this.reward, this.name, this.discount, this.discountPrice, this.startDate, this.isUsed, this.date, this.iV});

  DocsVoucher.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    voucherId = json['voucherId'];
    member = json['member'] != null ? new Member.fromJson(json['member']) : null;
    reward = json['reward'];
    name = json['name'];
    discount = json['discount'];
    discountPrice = json['discountPrice'];
    startDate = json['startDate'];
    isUsed = json['isUsed'];
    date = json['date'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['voucherId'] = this.voucherId;
    if (this.member != null) {
      data['member'] = this.member!.toJson();
    }
    data['reward'] = this.reward;
    data['name'] = this.name;
    data['discount'] = this.discount;
    data['discountPrice'] = this.discountPrice;
    data['startDate'] = this.startDate;
    data['isUsed'] = this.isUsed;
    data['date'] = this.date;
    data['__v'] = this.iV;
    return data;
  }
}

class Member {
  String? sId;
  String? memberId;
  String? fullname;

  Member({this.sId, this.memberId, this.fullname});

  Member.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    memberId = json['memberId'];
    fullname = json['fullname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['memberId'] = this.memberId;
    data['fullname'] = this.fullname;
    return data;
  }
}
