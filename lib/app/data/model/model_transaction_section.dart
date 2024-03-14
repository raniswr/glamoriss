class ModelTrasactionSection {
  int? status;
  String? message;
  Data? data;

  ModelTrasactionSection({this.status, this.message, this.data});

  ModelTrasactionSection.fromJson(Map<String, dynamic> json) {
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
  dynamic? prevPage;
  int? nextPage;

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
  String? transactionId;
  Patient? patient;
  Doctor? doctor;
  List<Items>? items;
  String? payment;
  String? status;
  int? tax;
  int? consultationPrice;
  int? point;
  int? pointCurrency;
  int? discount;
  int? discountPrice;
  int? totalPrice;
  String? voucher;
  bool? mobileOrder;
  String? branch;
  String? date;
  int? iV;

  Docs(
      {this.sId,
      this.transactionId,
      this.patient,
      this.doctor,
      this.items,
      this.payment,
      this.status,
      this.tax,
      this.consultationPrice,
      this.point,
      this.pointCurrency,
      this.discount,
      this.discountPrice,
      this.totalPrice,
      this.voucher,
      this.mobileOrder,
      this.branch,
      this.date,
      this.iV});

  Docs.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    transactionId = json['transactionId'];
    patient = json['patient'] != null ? new Patient.fromJson(json['patient']) : null;
    doctor = json['doctor'] != null ? new Doctor.fromJson(json['doctor']) : null;
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    payment = json['payment'];
    status = json['status'];
    tax = json['tax'];
    consultationPrice = json['consultationPrice'];
    point = json['point'];
    pointCurrency = json['pointCurrency'];
    discount = json['discount'];
    discountPrice = json['discountPrice'];
    totalPrice = json['totalPrice'];
    voucher = json['voucher'];
    mobileOrder = json['mobileOrder'];
    branch = json['branch'];
    date = json['date'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['transactionId'] = this.transactionId;
    if (this.patient != null) {
      data['patient'] = this.patient!.toJson();
    }
    if (this.doctor != null) {
      data['doctor'] = this.doctor!.toJson();
    }
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['payment'] = this.payment;
    data['status'] = this.status;
    data['tax'] = this.tax;
    data['consultationPrice'] = this.consultationPrice;
    data['point'] = this.point;
    data['pointCurrency'] = this.pointCurrency;
    data['discount'] = this.discount;
    data['discountPrice'] = this.discountPrice;
    data['totalPrice'] = this.totalPrice;
    data['voucher'] = this.voucher;
    data['mobileOrder'] = this.mobileOrder;
    data['branch'] = this.branch;
    data['date'] = this.date;
    data['__v'] = this.iV;
    return data;
  }
}

class Patient {
  String? sId;
  String? memberId;
  String? patientId;
  String? fullname;
  String? phone;

  Patient({this.sId, this.memberId, this.patientId, this.fullname, this.phone});

  Patient.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    memberId = json['memberId'];
    patientId = json['patientId'];
    fullname = json['fullname'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['memberId'] = this.memberId;
    data['patientId'] = this.patientId;
    data['fullname'] = this.fullname;
    data['phone'] = this.phone;
    return data;
  }
}

class Doctor {
  String? sId;
  String? userId;
  String? fullname;

  Doctor({this.sId, this.userId, this.fullname});

  Doctor.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    fullname = json['fullname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['fullname'] = this.fullname;
    return data;
  }
}

class Items {
  String? sId;
  String? name;
  String? image;
  String? category;
  bool? doctorCommision;
  int? qty;
  int? price;
  int? discount;
  int? discountPrice;
  int? commisionPrice;
  dynamic? treatmentRef;
  String? comparatorId;
  String? notes;

  Items(
      {this.sId,
      this.name,
      this.image,
      this.category,
      this.doctorCommision,
      this.qty,
      this.price,
      this.discount,
      this.discountPrice,
      this.commisionPrice,
      this.treatmentRef,
      this.comparatorId,
      this.notes});

  Items.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    image = json['image'];
    category = json['category'];
    doctorCommision = json['doctorCommision'];
    qty = json['qty'];
    price = json['price'];
    discount = json['discount'];
    discountPrice = json['discountPrice'];
    commisionPrice = json['commisionPrice'];
    treatmentRef = json['treatmentRef'];
    comparatorId = json['comparatorId'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['category'] = this.category;
    data['doctorCommision'] = this.doctorCommision;
    data['qty'] = this.qty;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['discountPrice'] = this.discountPrice;
    data['commisionPrice'] = this.commisionPrice;
    data['treatmentRef'] = this.treatmentRef;
    data['comparatorId'] = this.comparatorId;
    data['notes'] = this.notes;
    return data;
  }
}
