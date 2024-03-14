class ModelCardUpload {
  String? patient;
  List<ProductItems>? items;
  String? payment;
  double? tax;
  double? consultationPrice;
  double? totalPrice;
  String? voucher;
  String? branch;
  double? discountPrice;
  double? discount;
  double? pointCurrency;
  int? point;
  bool? mobileOrder;

  ModelCardUpload(
      {this.patient,
      this.items,
      this.payment,
      this.tax,
      this.consultationPrice,
      this.totalPrice,
      this.mobileOrder,
      this.voucher,
      this.discount,
      this.discountPrice,
      this.branch,
      this.point,
      this.pointCurrency});

  ModelCardUpload.fromJson(Map<String, dynamic> json) {
    patient = json['patient'];
    if (json['items'] != null) {
      items = <ProductItems>[];
      json['items'].forEach((v) {
        items?.add(ProductItems.fromJson(v));
      });
    }
    payment = json['payment'];
    tax = json['tax'];
    consultationPrice = json['consultationPrice'];
    totalPrice = json['totalPrice'];
    mobileOrder = json['mobileOrder'];
    voucher = json['voucher'];
    branch = json['branch'];
    discount = json['discount'];
    point = json['point'];
    pointCurrency = json['pointCurrency'];
    discountPrice = json['discountPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['patient'] = patient;
    if (items != null) {
      data['items'] = items?.map((v) => v.toJson()).toList();
    }
    data['payment'] = payment;
    data['tax'] = tax;
    data['consultationPrice'] = consultationPrice;
    data['totalPrice'] = totalPrice;
    data['branch'] = branch;
    data['mobileOrder'] = mobileOrder;
    data['voucher'] = voucher;
    data['discount'] = discount;
    data['point'] = point;
    data['pointCurrency'] = pointCurrency;
    data['discountPrice'] = discountPrice;
    return data;
  }
}

class ProductItems {
  String? sId;
  String? name;
  String? image;
  int? price;
  int? discount;
  int? discountPrice;
  int? qty;
  String? category;

  ProductItems({this.sId, this.name, this.image, this.price, this.discount, this.discountPrice, this.qty, this.category});

  ProductItems.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    image = json['image'];
    price = json['price'];
    discount = json['discount'];
    discountPrice = json['discountPrice'];
    qty = json['qty'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['image'] = image;
    data['price'] = price;
    data['discount'] = discount;
    data['discountPrice'] = discountPrice;
    data['qty'] = qty;
    data['category'] = category;
    return data;
  }
}
