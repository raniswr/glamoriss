class ModelBestSellerTreatment {
  int? status;
  String? message;
  List<Data>? data;

  ModelBestSellerTreatment({this.status, this.message, this.data});

  ModelBestSellerTreatment.fromJson(Map<String, dynamic> json) {
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
  List<Treatment>? treatment;

  Data({this.filter, this.treatment});

  Data.fromJson(Map<String, dynamic> json) {
    filter = json['filter'];
    if (json['treatment'] != null) {
      treatment = <Treatment>[];
      json['treatment'].forEach((v) {
        treatment!.add(new Treatment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['filter'] = this.filter;
    if (this.treatment != null) {
      data['treatment'] = this.treatment!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Treatment {
  String? sId;
  String? name;
  int? sales;
  int? price;
  String? image;

  Treatment({this.sId, this.name, this.sales, this.price, this.image});

  Treatment.fromJson(Map<String, dynamic> json) {
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
