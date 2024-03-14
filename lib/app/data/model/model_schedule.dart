class ScheduleModel {
  int? status;
  String? message;
  List<Data>? data;

  ScheduleModel({this.status, this.message, this.data});

  ScheduleModel.fromJson(Map<String, dynamic> json) {
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
  String? scheduleDate;
  Patient? patient;
  Patient? doctor;
  Transaction? transaction;
  bool? isVirtual;
  String? status;
  String? notes;
  String? virtualUrl;
  String? branch;
  String? date;
  int? iV;
  String? diagnosis;

  Data({this.sId, this.scheduleDate, this.patient, this.doctor, this.transaction, this.isVirtual, this.status, this.notes, this.virtualUrl, this.branch, this.date, this.iV, this.diagnosis});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    scheduleDate = json['scheduleDate'];
    patient = json['patient'] != null ? new Patient.fromJson(json['patient']) : null;
    doctor = json['doctor'] != null ? new Patient.fromJson(json['doctor']) : null;
    transaction = json['transaction'] != null ? new Transaction.fromJson(json['transaction']) : null;
    isVirtual = json['isVirtual'];
    status = json['status'];
    notes = json['notes'];
    virtualUrl = json['virtualUrl'];
    branch = json['branch'];
    date = json['date'];
    iV = json['__v'];
    diagnosis = json['diagnosis'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['scheduleDate'] = this.scheduleDate;
    if (this.patient != null) {
      data['patient'] = this.patient!.toJson();
    }
    if (this.doctor != null) {
      data['doctor'] = this.doctor!.toJson();
    }
    if (this.transaction != null) {
      data['transaction'] = this.transaction!.toJson();
    }
    data['isVirtual'] = this.isVirtual;
    data['status'] = this.status;
    data['notes'] = this.notes;
    data['virtualUrl'] = this.virtualUrl;
    data['branch'] = this.branch;
    data['date'] = this.date;
    data['__v'] = this.iV;
    data['diagnosis'] = this.diagnosis;
    return data;
  }
}

class Patient {
  String? sId;
  String? fullname;
  String? memberId;

  Patient({this.sId, this.fullname});

  Patient.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullname = json['fullname'];
    memberId = json['memberId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['fullname'] = this.fullname;
    data['memberId'] = this.memberId;
    return data;
  }
}

class Transaction {
  String? sId;
  String? transactionId;
  List<Items>? items;
  String? status;

  Transaction({this.sId, this.transactionId, this.items, this.status});

  Transaction.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    transactionId = json['transactionId'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['transactionId'] = this.transactionId;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Items {
  String? sId;
  Null? treatmentRef;
  String? name;
  String? category;
  bool? doctorCommision;
  int? qty;
  int? price;
  int? discount;
  int? discountPrice;
  int? commisionPrice;
  String? notes;

  Items({this.sId, this.treatmentRef, this.name, this.category, this.doctorCommision, this.qty, this.price, this.discount, this.discountPrice, this.commisionPrice, this.notes});

  Items.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    treatmentRef = json['treatmentRef'];
    name = json['name'];
    category = json['category'];
    doctorCommision = json['doctorCommision'];
    qty = json['qty'];
    price = json['price'];
    discount = json['discount'];
    discountPrice = json['discountPrice'];
    commisionPrice = json['commisionPrice'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['treatmentRef'] = this.treatmentRef;
    data['name'] = this.name;
    data['category'] = this.category;
    data['doctorCommision'] = this.doctorCommision;
    data['qty'] = this.qty;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['discountPrice'] = this.discountPrice;
    data['commisionPrice'] = this.commisionPrice;
    data['notes'] = this.notes;
    return data;
  }
}
