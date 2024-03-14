class ModelNotif {
  int? status;
  String? message;
  Data? data;

  ModelNotif({this.status, this.message, this.data});

  ModelNotif.fromJson(Map<String, dynamic> json) {
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
  bool? read;
  String? sId;
  Member? member;
  String? date;
  String? title;
  String? description;
  int? iV;
  bool? delivered;

  Docs({this.read, this.sId, this.member, this.date, this.title, this.description, this.iV, this.delivered});

  Docs.fromJson(Map<String, dynamic> json) {
    read = json['read'];
    sId = json['_id'];
    member = json['member'] != null ? new Member.fromJson(json['member']) : null;
    date = json['date'];
    title = json['title'];
    description = json['description'];
    iV = json['__v'];
    delivered = json['delivered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['read'] = this.read;
    data['_id'] = this.sId;
    if (this.member != null) {
      data['member'] = this.member!.toJson();
    }
    data['date'] = this.date;
    data['title'] = this.title;
    data['description'] = this.description;
    data['__v'] = this.iV;
    data['delivered'] = this.delivered;
    return data;
  }
}

class Member {
  String? sId;
  String? memberId;
  String? patientId;
  String? fullname;

  Member({this.sId, this.memberId, this.patientId, this.fullname});

  Member.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    memberId = json['memberId'];
    patientId = json['patientId'];
    fullname = json['fullname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['memberId'] = this.memberId;
    data['patientId'] = this.patientId;
    data['fullname'] = this.fullname;
    return data;
  }
}
