import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glamori/app/data/model/model_card_upload.dart';
import 'package:glamori/app/data/model/model_detail_product.dart';
import 'package:glamori/app/data/model/model_get_profile.dart';
import 'package:glamori/app/data/model/model_redeem.dart';
import 'package:glamori/app/data/model/model_redeemed.dart';
import 'package:glamori/app/data/services/api_services.dart';
import 'package:glamori/app/data/services/user_services.dart';
import 'package:glamori/app/routes/app_pages.dart';
import 'package:intl/intl.dart';

class PengirimanPageController extends GetxController {
  List<ModelDetailProduct?>? product;
  List<DocsVoucher?>? voucher;

  String? idUser;
  bool? isLogin;
  double subTotal = 0;
  double totalPrice = 0;
  double? totalPricePoin;
  double? totalPricePoinFinal;

  Future<String?> postTransaction(BuildContext context) async {
    if (idUser != null) {
      List<ProductItems> listItem = [];
      product?.forEach((element) {
        listItem.add(ProductItems(
          category: 'product',
          name: element?.data?.name ?? '',
          price: element?.data?.price ?? 0,
          qty: element?.qty ?? 1,
          discount: 0,
          discountPrice: 0,
          image: element?.data?.image ?? '',
          sId: element?.data?.sId,
        ));
      });
      var dataLokasi = await UserService.find.getLocationUser();

      ModelCardUpload cardUpload = ModelCardUpload(
        consultationPrice: 0,
        tax: 0,
        patient: idUser,
        payment: "cash",
        totalPrice: totalPricePointDiscount != 0 && usePoint == true
            ? totalPricePointDiscount
            : totalPricePoin != null && usePoint == true
                ? totalPricePoin
                : totalPrice2 != 0
                    ? totalPrice2
                    : totalPrice,
        mobileOrder: true,
        items: listItem,
        discount: totalPrice2 != 0 && discount1 != null ? discount1 : 0,
        discountPrice: data ?? 0,
        voucher: voucher?.first?.voucherId ?? '',
        branch: dataLokasi == 'JAKARTA' ? 'jakarta' : 'lampung',
        point: usePoint == true ? totalPoin : 0,
        pointCurrency: usePoint == true ? totalPricePoinFinal ?? 0 : 0,
      );

      var result = await ApiServices.postTransaction(modelCard: cardUpload);

      if (result != null) {
        log('berhasil');
        var id = result.data?.transactionId ?? '';
        return id;
      }
    } else {
      log("Belum login");
    }
    return null;
  }

  String formatPrice(double productPrice) {
    final formatter = NumberFormat.currency(
      symbol: 'Rp',
      decimalDigits: 0,
      locale: 'id_ID',
    );
    return formatter.format(productPrice);
  }

  String formatPriceNoRp(double productPrice) {
    final formatter = NumberFormat.currency(
      symbol: '',
      decimalDigits: 0,
      locale: 'id_ID',
    );
    return formatter.format(productPrice);
  }

  bool usePoint = false;
  void pointRedeem(bool value) {
    usePoint = value ?? false;
    update();
    if (value == true && totalPricePoin == 0) {
      totalPrice2 = 0;
      discountPrice = 0;
      discount1 = 0;
      voucher = null;
      data = 0;
      print('ini voucher null : ${voucher}');
      update();
    }
    if (pointToPrice != 0 && usePoint == true) {
      double sisaPoint = totalPrice - pointToPrice;
      if (sisaPoint != 0) {
        totalPricePointDiscount = totalPrice - pointToPrice - sisaPoint;
        print('ini total: $totalPricePointDiscount');
        update();
      } else {
        totalPricePointDiscount = totalPrice - data! - pointToPrice;
        print('ini totalnya: $totalPricePointDiscount');
        update();
      }

      update();
    }
    update();
  }

  var dataLokasi;
  @override
  void onReady() async {
    try {
      Map<String, dynamic>? arguments = Get.arguments;
      product = arguments?['product'] as List<ModelDetailProduct?>?;
      product?.forEach((element) {
        subTotal += (element?.data?.price ?? 0) * (element?.qty ?? 1);
      });

      totalPrice = subTotal;
      update();
    } catch (e) {
      log(e.toString());
    }
    dataLokasi = await UserService.find.getLocationUser();
    var dataLogin = await UserService.find.getLocalUser();

    if (dataLogin != null) {
      idUser = UserService.find.user?.id ?? '';
      isLogin = UserService.find.user?.isLogin;
      await getProfile(UserService.find.user?.id ?? '');
      update();
    }
    print('mimi $voucher');
    super.onReady();
  }

  checkPoint(value) {
    if (value < 2500) {
      update();
      return 0;
    } else {
      int count = value ~/ 2500;
      update();
      return count;
    }
  }

  int totalPoin = 0;
  ModelGetProfile? users;
  int pointToPrice = 0;
  var poinUser;

  getProfile(String id) async {
    var data = await ApiServices().getProfile(id);
    if (data != null) {
      users = data;
      update();
      int check = checkPoint(totalPrice);

      var poinUser = users?.data?.point;
      if (poinUser != 0 && poinUser! > 0) {
        pointToPrice = poinUser * 2500;
        totalPricePoin = totalPrice - pointToPrice;
        if (poinUser > check) {
          var minusPoin = poinUser - check;
          totalPoin = poinUser - minusPoin;
          pointToPrice = totalPrice.toInt();
          totalPricePoin = totalPrice - totalPrice;
          totalPricePoinFinal = totalPoin * 2500;
          print('total price poin ${totalPricePoin}');
          update();
        } else {
          totalPoin = poinUser;
          totalPricePoin = totalPrice - pointToPrice;
          totalPricePoinFinal = totalPoin * 2500;
          update();
        }
      }
      update();
    }
  }

  double? discount1;
  double? discountPrice;
  double? data;
  double totalPrice2 = 0;
  double totalPricePointDiscount = 0;
  toVoucher() {
    Get.toNamed(Routes.VOUCHER_PAGE)?.then((value) {
      try {
        voucher = value?['voucher'] as List<DocsVoucher?>?;
        if (voucher != null) {
          discount1 = voucher?.first?.discount?.toDouble();
          discountPrice = voucher?.first?.discountPrice?.toDouble() ?? 0;
          if (discount1 != null) {
            data = (totalPrice * discount1!.toDouble()) / 100;
            totalPrice2 = totalPrice - data!;
            if (pointToPrice != 0 && usePoint == true && totalPricePoin != 0) {
              totalPricePointDiscount = totalPrice - data! - pointToPrice;
              update();
            }
          } else if (discountPrice != null) {
            totalPrice2 = totalPrice - discountPrice!;
            if (pointToPrice != 0 && usePoint == true) {
              totalPricePointDiscount = totalPrice - data! - pointToPrice;

              update();
            }
          } else {
            discount1 = 0;
            discountPrice = 0;
            totalPrice2 = 0;
            data = 0;
          }
        } else {
          totalPrice2 = 0;
          discountPrice = 0;
          discount1 = 0;
          voucher = null;
          data = 0;
        }

        update();
      } catch (_) {}
    });
    print('hihi $voucher');
  }
}
