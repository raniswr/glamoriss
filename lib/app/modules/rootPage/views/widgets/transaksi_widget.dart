import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glamori/app/data/model/model_detail_product.dart';
import 'package:glamori/app/modules/rootPage/controllers/root_page_controller.dart';
import 'package:glamori/app/routes/app_pages.dart';
import 'package:glamori/core/assets.dart';
import 'package:glamori/core/themes/colors.dart';
import 'package:glamori/core/themes/style.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TransaksiWidget extends StatelessWidget {
  const TransaksiWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RootPageController>(builder: (controller) {
      return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.secondary,
            centerTitle: true,
            title: Text(
              'Pembelian',
              textAlign: TextAlign.center,
              style: AppStyle.styleTextBody18(fontWeight: FontWeight.bold),
            ),
            automaticallyImplyLeading: false,
          ),
          backgroundColor: AppColors.secondary,
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                await controller.getBelumDibayar();
                await controller.getSudahDibeli();
              },
              child: Column(
                children: [
                  TabBar(
                    indicatorColor: AppColors.primary,
                    labelColor: AppColors.yellow,
                    labelStyle: AppStyle.styleTextBody16(),
                    // unselectedLabelColor: AppColors.inactiveIconColor,
                    unselectedLabelStyle: AppStyle.styleTextBody16(colorText: AppColors.textBlack),
                    onTap: (value) async {
                      if (value == 0) {
                        await controller.getBelumDibayar();
                      } else if (value == 1) {
                        await controller.getSudahDibeli();
                      }
                    },
                    tabs: const [
                      Tab(
                        child: Text(
                          'Belum Dibayar',
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Sudah Dibeli',
                        ),
                      ),
                    ],
                  ),
                  const Expanded(
                    child: TabBarView(physics: NeverScrollableScrollPhysics(), children: <Widget>[
                      BelumDibayarItem(),
                      SudahDibeliItem(),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class BelumDibayarItem extends StatelessWidget {
  const BelumDibayarItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RootPageController>(builder: (controller) {
      return RefreshIndicator(
        onRefresh: () async {
          await controller.getBelumDibayar();
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              children: [
                controller.isLoadinggetBelumDibayar
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : controller.transaction?.data?.docs! != null
                        ? ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.transaction?.data?.docs?.length ?? 0,
                            primary: false,
                            itemBuilder: (context, index) {
                              var number = controller.transaction?.data?.docs?[index]?.items?.length.toInt();
                              // var leghtItem = controller.transaction?.data?.docs?[index]?.items?.isEmpty;
                              print("test: " + number.toString());
                              // print(leghtItem);
                              var leghtItem = controller.transaction?.data?.docs?[index]?.items?.first?.category;
                              return leghtItem == 'treatment'
                                  ? SizedBox.shrink()
                                  : Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(25),
                                            color: AppColors.white,
                                            boxShadow: const [
                                              BoxShadow(
                                                color: AppColors.grey,
                                                spreadRadius: 0.2,
                                                blurRadius: 0.5,
                                                offset: Offset(0, 0.2),
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  controller.transaction?.data?.docs?[index].items?.first.image != null
                                                      ? ClipRRect(
                                                          borderRadius: const BorderRadius.only(
                                                            topLeft: Radius.circular(16.0),
                                                            topRight: Radius.circular(16.0),
                                                            bottomLeft: Radius.circular(16.0),
                                                            bottomRight: Radius.circular(16.0),
                                                          ),
                                                          child: Image.network(
                                                            controller.transaction?.data?.docs?[index].items?.first.image ?? '',
                                                            width: 65,
                                                            height: 60,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ).marginOnly(bottom: 10, left: 10, right: 10)
                                                      : ExtendedImage.asset(
                                                          Assets.product,
                                                          width: 65,
                                                          height: 60,
                                                          fit: BoxFit.fill,
                                                        ).marginOnly(bottom: 10, left: 10, right: 10),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          (controller.transaction?.data?.docs?[index].items?.first.name ?? ''),
                                                          style: AppStyle.styleTextBody15(fontWeight: FontWeight.bold),
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            controller.transaction?.data?.docs?[index].discount != 0
                                                                ? Column(
                                                                    children: [
                                                                      SizedBox(height: 5),
                                                                      Container(
                                                                        height: 25,
                                                                        width: 90,
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(5),
                                                                          color: AppColors.white,
                                                                          border: Border.all(color: AppColors.primary, width: 1),
                                                                        ),
                                                                        child: Center(
                                                                          child: Text(
                                                                            'Diskon ${controller.transaction?.data?.docs?[index].discount ?? ' '}%',
                                                                            style: AppStyle.styleTextBody11(fontWeight: FontWeight.w500),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(height: 5),
                                                                    ],
                                                                  )
                                                                : SizedBox.shrink(),
                                                          ],
                                                        ),
                                                        Text(
                                                          '${controller.transaction?.data?.docs?[index].items?.first.qty}x',
                                                          style: AppStyle.styleTextBody14(),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            showAlertDialog(context, index);
                                                          },
                                                          child: controller.minusFunction(number!) > 0
                                                              ? Text(
                                                                  'Lihat ${controller.minusFunction(number!)} Produk lainnya',
                                                                  style: AppStyle.styleTextBody10(colorText: AppColors.blue)
                                                                      .copyWith(decoration: TextDecoration.underline, decorationColor: AppColors.blue),
                                                                )
                                                              : SizedBox.shrink(),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        controller.formatPrice(controller.transaction?.data?.docs?[index].items?.first.price ?? 0),
                                                        style: AppStyle.styleTextBody15(colorText: AppColors.yellow, fontWeight: FontWeight.w600),
                                                      ).marginOnly(left: 15),
                                                      controller.transaction?.data?.docs?[index].discount != 0
                                                          ? Text(
                                                              '${controller.transaction?.data?.docs?[index].discount ?? 0}%',
                                                              style: AppStyle.styleTextBody15(colorText: AppColors.yellow, fontWeight: FontWeight.w600),
                                                            ).marginOnly(left: 65)
                                                          : SizedBox.shrink(),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                width: double.infinity,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: AppColors.yellowSoft,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Total Pesanan',
                                                      style: AppStyle.styleTextBody13(fontWeight: FontWeight.w600),
                                                    ),
                                                    Text(
                                                      controller.formatPrice(controller.transaction?.data?.docs?[index].totalPrice?.toInt() ?? 0),
                                                      style: AppStyle.styleTextBody13(fontWeight: FontWeight.w600, colorText: AppColors.yellow),
                                                    ),
                                                  ],
                                                ).marginSymmetric(horizontal: 10),
                                              ).marginSymmetric(vertical: 5).marginOnly(left: 20),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      SvgPicture.asset(
                                                        Assets.icMap,
                                                        width: 13,
                                                      ).marginOnly(right: 5),
                                                      Text(
                                                        '${controller.transaction?.data?.docs?[index].branch == 'jakarta' ? 'Jakarta' : 'Lampung'}',
                                                        textAlign: TextAlign.center,
                                                        style: AppStyle.styleTextBody14(),
                                                      ).marginOnly(),
                                                    ],
                                                  ).marginOnly(left: 20),
                                                  GestureDetector(
                                                    onTap: () {
                                                      showAlertDialogBarcode(context, controller.transaction?.data?.docs?[index].transactionId);
                                                    },
                                                    child: Container(
                                                      height: 30,
                                                      width: 80,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(20),
                                                        color: AppColors.primary,
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text(
                                                            'Bayar',
                                                            style: AppStyle.styleTextBody14(colorText: AppColors.white),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ).marginOnly(top: 10),
                                            ],
                                          ).marginOnly(top: 20, right: 20, bottom: 20))
                                      .marginAll(5);
                            },
                          )
                        : SizedBox.shrink(),
                // : SizedBox.shrink(),
                const SizedBox(height: 120),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class SudahDibeliItem extends StatelessWidget {
  const SudahDibeliItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RootPageController>(builder: (controller) {
      return RefreshIndicator(
        onRefresh: () async {
          await controller.getSudahDibeli();
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 10, 0),
            child: Column(
              children: [
                controller.isLoadinggetSudahDibeli
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : controller.sudahDibeli?.data != null
                        ? ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: (controller.sudahDibeli?.data?.docs ?? []).where((doc) => doc != '').length,
                            primary: false,
                            itemBuilder: (context, index) {
                              var doc = controller.sudahDibeli!.data!.docs![index];
                              var items = doc.items ?? [];
                              var firstItem = items.isNotEmpty ? items.first : null;
                              var number = items.length;

                              print("test: " + number.toString());

                              var leghtItem = controller.sudahDibeli?.data?.docs?[index].items?.first.category;
                              return leghtItem == 'treatment'
                                  ? SizedBox.shrink()
                                  : leghtItem == true || leghtItem == null
                                      ? SizedBox.shrink()
                                      : Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(25),
                                            color: AppColors.white,
                                            boxShadow: const [
                                              BoxShadow(
                                                color: AppColors.grey,
                                                spreadRadius: 0.2,
                                                blurRadius: 0.5,
                                                offset: Offset(0, 0.2),
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    child: controller.sudahDibeli?.data?.docs?[index].items?.first.image != null
                                                        ? ClipRRect(
                                                            borderRadius: const BorderRadius.only(
                                                              topLeft: Radius.circular(16.0),
                                                              topRight: Radius.circular(16.0),
                                                              bottomLeft: Radius.circular(16.0),
                                                              bottomRight: Radius.circular(16.0),
                                                            ),
                                                            child: Image.network(
                                                              controller.sudahDibeli?.data?.docs?[index].items?.first.image ?? '',
                                                              width: 65,
                                                              height: 60,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ).marginOnly(bottom: 5, left: 10, right: 10)
                                                        : ExtendedImage.asset(
                                                            Assets.product,
                                                            width: 65,
                                                            height: 60,
                                                            fit: BoxFit.fill,
                                                          ).marginOnly(bottom: 10, left: 10, right: 10),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          (firstItem?.name ?? ''),
                                                          style: AppStyle.styleTextBody15(fontWeight: FontWeight.bold),
                                                          maxLines: 3,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            controller.sudahDibeli?.data?.docs?[index].discount != 0
                                                                ? Column(
                                                                    children: [
                                                                      SizedBox(height: 5),
                                                                      Container(
                                                                        height: 25,
                                                                        width: 90,
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(5),
                                                                          color: AppColors.white,
                                                                          border: Border.all(color: AppColors.primary, width: 1),
                                                                        ),
                                                                        child: Center(
                                                                          child: Text(
                                                                            'Diskon ${controller.sudahDibeli?.data?.docs?[index].discount ?? ' '}%',
                                                                            style: AppStyle.styleTextBody11(fontWeight: FontWeight.w500),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(height: 5),
                                                                    ],
                                                                  )
                                                                : SizedBox.shrink(),
                                                          ],
                                                        ),
                                                        Text(
                                                          '${firstItem?.qty}x',
                                                          style: AppStyle.styleTextBody14(),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            showAlertDialogSudahDibeli(context, index);
                                                          },
                                                          child: controller.minusFunction(number) > 0
                                                              ? Text(
                                                                  'Lihat ${controller.minusFunction(number)} Produk lainnya',
                                                                  style: AppStyle.styleTextBody10(colorText: AppColors.blue)
                                                                      .copyWith(decoration: TextDecoration.underline, decorationColor: AppColors.blue),
                                                                )
                                                              : SizedBox.shrink(),
                                                        ),
                                                      ],
                                                    ).marginOnly(top: 10),
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        controller.formatPrice(firstItem?.price ?? 0),
                                                        style: AppStyle.styleTextBody15(colorText: AppColors.yellow, fontWeight: FontWeight.w600),
                                                      ).marginOnly(left: 15),
                                                      controller.sudahDibeli?.data?.docs?[index].discount != 0
                                                          ? Text(
                                                              '${controller.sudahDibeli?.data?.docs?[index].discount ?? 0}%',
                                                              style: AppStyle.styleTextBody15(colorText: AppColors.yellow, fontWeight: FontWeight.w600),
                                                            ).marginOnly(left: 65)
                                                          : SizedBox.shrink(),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                width: double.infinity,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: AppColors.yellowSoft,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Total Pesanan',
                                                      style: AppStyle.styleTextBody13(fontWeight: FontWeight.w600),
                                                    ),
                                                    Text(
                                                      controller.formatPrice(doc.totalPrice ?? 0),
                                                      style: AppStyle.styleTextBody13(fontWeight: FontWeight.w600, colorText: AppColors.yellow),
                                                    ),
                                                  ],
                                                ).marginSymmetric(horizontal: 10),
                                              ).marginSymmetric(vertical: 5).marginOnly(left: 20),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      SvgPicture.asset(
                                                        Assets.icMap,
                                                        width: 13,
                                                      ).marginOnly(right: 5),
                                                      Text(
                                                        '${controller.transaction?.data?.docs?[index].branch == 'jakarta' ? 'Jakarta' : 'Lampung'}',
                                                        textAlign: TextAlign.center,
                                                        style: AppStyle.styleTextBody14(),
                                                      ).marginOnly(),
                                                    ],
                                                  ).marginOnly(left: 20),
                                                  GestureDetector(
                                                    onTap: () {
                                                      List<ModelDetailProduct?> listProduct = [];
                                                      items.forEach((element) {
                                                        listProduct.add(
                                                          ModelDetailProduct(
                                                            checked: 1,
                                                            data: DataModelDetail(
                                                              name: element.name,
                                                              price: element.price,
                                                              iV: doc.iV,
                                                              image: element.treatmentRef ??
                                                                  'https://res.cloudinary.com/dk0z4ums3/image/upload/v1633952488/attached_image/daftar-kandungan-skincare-yang-baik-untuk-dikombinasikan.jpg',
                                                              sId: element.sId,
                                                            ),
                                                            qty: element.qty,
                                                          ),
                                                        );
                                                      });
                                                      Get.toNamed(
                                                        Routes.pengirimanPage,
                                                        arguments: {
                                                          'product': listProduct,
                                                        },
                                                      );
                                                    },
                                                    child: Container(
                                                      height: 30,
                                                      width: 80,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(20),
                                                        border: Border.all(color: AppColors.primary, width: 1),
                                                        color: AppColors.white,
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text(
                                                            'Beli Lagi',
                                                            style: AppStyle.styleTextBody14(),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ).marginOnly(top: 10, right: 10, bottom: 8),
                                            ],
                                          ).marginOnly(top: 20, right: 20, bottom: 20),
                                        ).marginOnly(top: 20, right: 20, bottom: 20);
                            },
                          )
                        : SizedBox.shrink(),
                const SizedBox(height: 120),
              ],
            ),
          ),
        ),
      );
    });
  }
}

showAlertDialog(BuildContext context, index) {
  AlertDialog alert = AlertDialog(
    backgroundColor: AppColors.white,
    surfaceTintColor: Colors.transparent,
    content: GetBuilder<RootPageController>(builder: (controller) {
      int itemCount = controller.transaction?.data?.docs?[index]?.items?.length ?? 0;
      double contentHeight = 150 + itemCount * 40.0; // Calculate the height dynamically

      return SizedBox(
        height: contentHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      "List Produk",
                      textAlign: TextAlign.center,
                      style: AppStyle.styleTextBody16(fontWeight: FontWeight.bold),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.close,
                      color: AppColors.textBlack,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: contentHeight - 40, // Adjusted height for the ListView
              width: 400,
              child: ListView.builder(
                itemCount: itemCount,
                itemBuilder: (context, indexs) {
                  return Container(
                    width: double.infinity,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.primary, width: 1),
                      color: AppColors.white,
                    ),
                    child: Row(
                      children: [
                        controller.transaction?.data?.docs?[index]?.items?[indexs]?.image != null
                            ? ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                  bottomLeft: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0),
                                ),
                                child: Image.network(
                                  controller.transaction?.data?.docs?[index].items?[indexs].image ?? '',
                                  width: 55,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                              ).marginOnly(left: 10, right: 10)
                            : ExtendedImage.asset(
                                Assets.product,
                                width: 55,
                                height: 50,
                                fit: BoxFit.fill,
                              ).marginOnly(bottom: 10, left: 20, right: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                controller.transaction?.data?.docs?[index].items?[indexs].name ?? '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: AppStyle.styleTextBody14(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                controller.formatPrice(controller.transaction?.data?.docs?[index].items?[indexs].price ?? 0),
                                style: AppStyle.styleTextBody14(),
                              )
                            ],
                          ),
                        ),
                        Text(
                          'x${controller.transaction?.data?.docs?[index].items?[indexs].qty}',
                          style: AppStyle.styleTextBody14(fontWeight: FontWeight.bold),
                        ).marginOnly(right: 20),
                      ],
                    ),
                  ).marginOnly(top: 10);
                },
              ),
            ),
          ],
        ),
      );
    }),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlertDialogSudahDibeli(BuildContext context, index) {
  AlertDialog alert = AlertDialog(
    backgroundColor: AppColors.white,
    surfaceTintColor: Colors.transparent,
    content: GetBuilder<RootPageController>(builder: (controller) {
      int itemCount = controller.sudahDibeli?.data?.docs?[index].items?.length ?? 0;
      double contentHeight = 150 + itemCount * 40.0; // Calculate the height dynamically

      return SizedBox(
        height: contentHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      "List Produk",
                      textAlign: TextAlign.center,
                      style: AppStyle.styleTextBody16(fontWeight: FontWeight.bold),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.close,
                      color: AppColors.textBlack,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: contentHeight - 40, // Adjusted height for the ListView
              width: 400,
              child: ListView.builder(
                itemCount: itemCount,
                itemBuilder: (context, indexs) {
                  return Container(
                    width: double.infinity,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.primary, width: 1),
                      color: AppColors.white,
                    ),
                    child: Row(
                      children: [
                        controller.sudahDibeli?.data?.docs?[index].items?[indexs].treatmentRef != null
                            ? ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                  bottomLeft: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0),
                                ),
                                child: Image.network(
                                  controller.sudahDibeli?.data?.docs?[index].items?[indexs].treatmentRef ?? '',
                                  width: 55,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                              ).marginOnly(left: 10, right: 10)
                            : ExtendedImage.asset(
                                Assets.product,
                                width: 55,
                                height: 50,
                                fit: BoxFit.fill,
                              ).marginOnly(bottom: 10, left: 20, right: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                controller.sudahDibeli?.data?.docs?[index].items?[indexs].name ?? '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: AppStyle.styleTextBody14(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                controller.formatPrice(controller.sudahDibeli?.data?.docs?[index].items?[indexs].price ?? 0),
                                style: AppStyle.styleTextBody14(),
                              )
                            ],
                          ),
                        ),
                        Text(
                          'x${controller.sudahDibeli?.data?.docs?[index].items?[indexs].qty}',
                          style: AppStyle.styleTextBody14(fontWeight: FontWeight.bold),
                        ).marginOnly(right: 20),
                      ],
                    ),
                  ).marginOnly(top: 10);
                },
              ),
            ),
          ],
        ),
      );
    }),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void showAlertDialogBarcode(BuildContext context, String? id) {
  final double topPadding = MediaQuery.of(context).size.height / 4;

  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (BuildContext buildContext, Animation<double> animation, Animation<double> secondaryAnimation) {
      return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          return Transform.translate(
            offset: Offset(0.0, -topPadding + (topPadding * animation.value)),
            child: Opacity(
              opacity: animation.value,
              child: child,
            ),
          );
        },
        child: Center(
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
            margin: const EdgeInsets.all(45),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(
                      child: Text(
                        "QR Code",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        Icons.close,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                const Text(
                  "Untuk Pembayaran Silahkan Scan QR Code ini",
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  width: double.infinity,
                  child: QrImageView(
                    data: id ?? '',
                    version: QrVersions.auto,
                  ),
                ),
                Text(
                  id ?? '',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
