// ignore_for_file: deprecated_member_use

import 'dart:developer';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glamori/app/modules/rootPage/controllers/root_page_controller.dart';
import 'package:glamori/app/routes/app_pages.dart';
import 'package:glamori/core/assets.dart';
import 'package:glamori/core/themes/colors.dart';
import 'package:glamori/core/themes/style.dart';
import 'package:glamori/utils/sqlite_helper.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/pengiriman_page_controller.dart';

class PengirimanPageView extends GetView<PengirimanPageController> {
  const PengirimanPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.secondary,
        title: Text(
          'Check-Out',
          textAlign: TextAlign.center,
          style: AppStyle.styleTextBody18(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: SvgPicture.asset(
            Assets.icBack,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const AnimatedBottomBar(),
      body: GetBuilder<PengirimanPageController>(
          init: PengirimanPageController(),
          builder: (controller) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        width: 1,
                        color: AppColors.yellow,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.grey,
                          spreadRadius: 0.3,
                          blurRadius: 0.7,
                          offset: Offset(0, 0.4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          Assets.icInfo,
                          width: 30,
                          color: AppColors.yellow,
                        ).marginSymmetric(horizontal: 20),
                        Expanded(
                          child: Text(
                            'Barang Yang Dibeli Dalam Aplikasi Hanya Bisa Diambil Di Klinik Glamori ${controller.dataLokasi == 'jakarta' ? 'Jakarta' : 'Lampung'}',
                            style: AppStyle.styleTextBody14(colorText: Colors.black),
                          ).marginSymmetric(horizontal: 5),
                        ),
                      ],
                    ).marginAll(5),
                  ).marginAll(15),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: AppColors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.grey,
                          spreadRadius: 0.3,
                          blurRadius: 0.7,
                          offset: Offset(0, 0.4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              Assets.icProduct,
                            ),
                            Text(
                              'Produk',
                              style: AppStyle.styleTextBody16(fontWeight: FontWeight.w600),
                            ).marginOnly(left: 5),
                          ],
                        ),
                        Container(
                          // width: double.infinity,
                          // height: 110,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.primary, width: 1),
                            color: AppColors.white,
                          ),
                          child: controller.product == null
                              ? const SizedBox.shrink()
                              : ListView.builder(
                                  itemCount: controller.product?.length,
                                  shrinkWrap: true,
                                  primary: false,
                                  itemBuilder: (context, index) {
                                    var item = controller.product?[index];
                                    return Row(
                                      children: [
                                        item?.data?.image != null
                                            ? Image.network(
                                                item?.data?.image ?? '',
                                                width: 70,
                                                fit: BoxFit.fill,
                                              ).marginSymmetric(vertical: 5, horizontal: 10)
                                            : const SizedBox.shrink(),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                item?.data?.name ?? '',
                                                style: AppStyle.styleTextBody14(fontWeight: FontWeight.bold),
                                              ),
                                              Text(
                                                controller.formatPrice(item?.data?.price?.toDouble() ?? 0),
                                                style: AppStyle.styleTextBody14(),
                                              )
                                            ],
                                          ),
                                        ),
                                        Text(
                                          'x${item?.qty ?? 1}',
                                          style: AppStyle.styleTextBody14(fontWeight: FontWeight.bold),
                                        ).marginOnly(right: 20),
                                      ],
                                    ).marginSymmetric(vertical: 10);
                                  },
                                ),
                        ).marginOnly(top: 20),
                      ],
                    ).marginAll(20),
                  ).marginSymmetric(horizontal: 20),
                  Container(
                    width: double.infinity,
                    // height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: AppColors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.grey,
                          spreadRadius: 0.3,
                          blurRadius: 0.7,
                          offset: Offset(0, 0.4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        controller.voucher == null
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        Assets.icCoin,
                                      ),
                                      Text(
                                        // 'Tukarkan ${controller.voucher?.first?.isUsed ?? 0} poin',
                                        'Tukarkan ${controller.totalPoin} poin ',
                                        style: AppStyle.styleTextBody16(fontWeight: FontWeight.w500),
                                      ).marginOnly(left: 5),
                                    ],
                                  ),
                                  Transform.scale(
                                    scale: 0.8, // Adjust the scale factor as needed
                                    child: Switch(
                                      value: controller.usePoint,
                                      onChanged: (value) {
                                        controller.totalPoin == 0 ? '' : controller.pointRedeem(value);
                                      },
                                      activeTrackColor: AppColors.yellow,
                                      activeColor: AppColors.grey,
                                      inactiveThumbColor: AppColors.yellow,
                                      trackOutlineColor: MaterialStateProperty.all(AppColors.yellow),
                                    ),
                                  )
                                ],
                              )
                            : SizedBox.shrink(),
                        controller.voucher == null && controller.usePoint == false
                            ? Divider(
                                thickness: 0.1,
                              ).marginOnly(top: 10)
                            : SizedBox.shrink(),
                        // controller.usePoint == true
                        //     ? SizedBox.shrink()
                        //     : Container(
                        //         width: double.infinity,
                        //         height: 30,
                        //         // color: Colors.red,
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //           children: [
                        //             Row(
                        //               children: [
                        //                 SvgPicture.asset(
                        //                   Assets.icVoucher,
                        //                 ),
                        //                 Text(
                        //                   'Voucher',
                        //                   style: AppStyle.styleTextBody16(fontWeight: FontWeight.w500),
                        //                 ).marginOnly(left: 5),
                        //               ],
                        //             ),
                        //             Expanded(
                        //               child: Row(
                        //                 mainAxisAlignment: MainAxisAlignment.end,
                        //                 children: [
                        //                   controller.voucher?.first?.name != null && controller.usePoint == false && controller.totalPoin != 0
                        //                       ? Container(
                        //                           height: 25,
                        //                           width: 90,
                        //                           decoration: BoxDecoration(
                        //                             borderRadius: BorderRadius.circular(5),
                        //                             color: AppColors.white,
                        //                             border: Border.all(color: AppColors.primary, width: 1),
                        //                           ),
                        //                           child: Center(
                        //                             child: Text(
                        //                               controller.voucher?.first?.name ?? '',
                        //                               style: AppStyle.styleTextBody11(fontWeight: FontWeight.w500),
                        //                             ),
                        //                           ),
                        //                         )
                        //                       : controller.usePoint == true && controller.totalPricePoin == 0
                        //                           ? Expanded(
                        //                               child: Text(
                        //                                 'Seluruh poin telah digunakan',
                        //                                 maxLines: 1,
                        //                                 style: AppStyle.styleTextBody11(fontWeight: FontWeight.w500),
                        //                               ).marginOnly(left: 5),
                        //                             )
                        //                           : controller.voucher?.first?.name != null && controller.usePoint == true
                        //                               ? Container(
                        //                                   height: 25,
                        //                                   width: 90,
                        //                                   decoration: BoxDecoration(
                        //                                     borderRadius: BorderRadius.circular(5),
                        //                                     color: AppColors.white,
                        //                                     border: Border.all(color: AppColors.primary, width: 1),
                        //                                   ),
                        //                                   child: Center(
                        //                                     child: Text(
                        //                                       controller.voucher?.first?.name ?? '',
                        //                                       style: AppStyle.styleTextBody11(fontWeight: FontWeight.w500),
                        //                                     ),
                        //                                   ),
                        //                                 )
                        //                               : SizedBox.shrink(),
                        //                   GestureDetector(
                        //                     onTap: () {
                        //                       controller.toVoucher();
                        //                     },
                        //                     child: const Icon(
                        //                       Icons.arrow_forward,
                        //                       color: AppColors.yellow,
                        //                     ),
                        //                   )
                        //                 ],
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                      ],
                    ).marginAll(20),
                  ).marginSymmetric(horizontal: 20).marginOnly(top: 20),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: AppColors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.grey,
                          spreadRadius: 0.3,
                          blurRadius: 0.7,
                          offset: Offset(0, 0.4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              Assets.icRincian,
                            ),
                            Text(
                              'Rincian pembayaran',
                              style: AppStyle.styleTextBody16(fontWeight: FontWeight.w500),
                            ).marginOnly(left: 5),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Subtotal Produk',
                              style: AppStyle.styleTextBody14(),
                            ),
                            Text(
                              controller.formatPrice(controller.subTotal),
                              style: AppStyle.styleTextBody14(fontWeight: FontWeight.w600),
                            )
                          ],
                        ).marginOnly(top: 10),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Poin Telah Digunakan',
                              style: AppStyle.styleTextBody14(),
                            ),
                            Text(
                              controller.usePoint == true ? '-Rp.${controller.pointToPrice}' : '0',
                              style: AppStyle.styleTextBody14(fontWeight: FontWeight.w600),
                            )
                          ],
                        ).marginOnly(top: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Diskon',
                              style: AppStyle.styleTextBody14(),
                            ),
                            Text(
                              controller.voucher?.first?.discount != null && controller.usePoint == false
                                  ? '${controller.voucher?.first?.discount}%'
                                  : controller.usePoint == true && controller.totalPricePoin == 0
                                      ? '0'
                                      : controller.usePoint == true && controller.totalPricePoin != 0
                                          ? '${controller.voucher?.first?.discount ?? 0}%'
                                          : controller.voucher?.first?.discountPrice != null
                                              ? '${controller.voucher?.first?.discountPrice}%'
                                              : '0',
                              style: AppStyle.styleTextBody14(fontWeight: FontWeight.w600),
                            )
                          ],
                        ).marginOnly(top: 10),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Text(
                        //       'PPN (%)',
                        //       style: AppStyle.styleTextBody14(),
                        //     ),
                        //     Text(
                        //       '10%',
                        //       style: AppStyle.styleTextBody14(fontWeight: FontWeight.w600),
                        //     )
                        //   ],
                        // ).marginSymmetric(vertical: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Pembayaran',
                              style: AppStyle.styleTextBody14(fontWeight: FontWeight.w600),
                            ).marginOnly(top: 10),
                            Text(
                              controller.formatPrice(controller.totalPrice),
                              style: AppStyle.styleTextBody14(
                                fontWeight: FontWeight.w600,
                                decoration: controller.totalPrice2 != 0
                                    ? TextDecoration.lineThrough
                                    : controller.totalPricePoin != 0 && controller.usePoint == true && controller.totalPricePoin != null
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                              ),
                            )
                          ],
                        ),
                        controller.totalPrice2 != 0 || controller.totalPricePoin != null
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    controller.totalPricePoin != 0 && controller.totalPrice2 != 0 && controller.usePoint == true
                                        ? controller.formatPrice(controller.totalPricePointDiscount)
                                        : controller.totalPrice2 != 0 && controller.usePoint == false
                                            ? controller.formatPrice(controller.totalPrice2)
                                            : controller.totalPricePoin != null && controller.usePoint == true && controller.totalPricePointDiscount == 0
                                                ? controller.formatPrice(controller.totalPricePoin!)
                                                : '',
                                    style: AppStyle.styleTextBody14(
                                      fontWeight: FontWeight.w600,
                                      colorText: AppColors.yellow,
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox.shrink()
                      ],
                    ).marginAll(20),
                  ).marginSymmetric(horizontal: 20, vertical: 20),
                  const SizedBox(height: 120),
                ],
              ),
            );
          }),
    );
  }
}

class AnimatedBottomBar extends StatelessWidget {
  const AnimatedBottomBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PengirimanPageController>(builder: (controller) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 75,
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 5),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 0.3),
              ),
            ],
          ),
          child: Row(
            children: [
              SizedBox(
                // height: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Pembayaran',
                      style: AppStyle.styleTextBody14(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      controller.totalPricePoin != null && controller.totalPrice2 != 0 && controller.usePoint == true
                          ? controller.formatPrice(controller.totalPricePointDiscount)
                          : controller.totalPrice2 != 0 && controller.usePoint == false
                              ? controller.formatPrice(controller.totalPrice2)
                              : controller.totalPricePoin != null && controller.usePoint == true && controller.totalPricePointDiscount == 0
                                  ? controller.formatPrice(controller.totalPricePoin!)
                                  : controller.formatPrice(controller.totalPrice),
                      style: AppStyle.styleTextBody14(colorText: AppColors.yellow, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (controller.isLogin == true) {
                      showAlertDialog(context);
                    } else {
                      Get.toNamed(Routes.LOGIN_PAGE);
                    }
                  },
                  child: Container(
                    height: 40,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: AppColors.primary,
                    ),
                    child: Center(
                      child: Text(
                        'Beli Sekarang',
                        style: AppStyle.styleTextBody16(colorText: AppColors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class ItemStore extends StatelessWidget {
  const ItemStore({
    Key? key,
    required this.title,
    required this.icon,
    required this.link,
  }) : super(key: key);

  final String title;
  final String icon;
  final String link;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (await canLaunch(link)) {
          await launch(link);
        } else {
          log('Could not launch $link');
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 60,
            width: 60,
            child: ExtendedImage.asset(
              icon,
              height: 60,
              width: 60,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 80,
            child: Text(
              title,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: AppStyle.styleTextBody14(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    backgroundColor: AppColors.white,
    surfaceTintColor: Colors.transparent,
    title: Text(
      "Barang di Keranjang Hanya Dapat di Check-Out Melalui Klinik Glamori",
      textAlign: TextAlign.center,
      style: AppStyle.styleTextBody16(),
    ),
    content: Text(
      "Apakah Anda Yakin?",
      textAlign: TextAlign.center,
      style: AppStyle.styleTextBody16(fontWeight: FontWeight.w600),
    ),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                  height: 40,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: AppColors.primary, width: 1),
                    color: AppColors.white,
                  ),
                  child: Center(
                    child: Text(
                      'Tidak',
                      style: AppStyle.styleTextBody16(),
                    ),
                  ))).marginOnly(right: 20),
          GetBuilder<PengirimanPageController>(builder: (controller) {
            return ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                var id = await controller.postTransaction(context);
                // ignore: use_build_context_synchronously
                print("Transaction ID: $id");
                if (id != null) {
                  showAlertDialogBarcode(context, id, context);
                }
                var sqlHelper = await SqlLiteHelper.instance.cartTable;
                await sqlHelper.deleteCartProduct();
              },
              style: AppStyle.styleButton(borderRadius: 18, width: 80, height: 10),
              child: Text(
                'Ya',
                style: AppStyle.styleTextBody16(colorText: AppColors.white),
              ),
            );
          })
        ],
      ),
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlertDialogBarcode(BuildContext context, String? id, BuildContext contextPage) {
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
                    Expanded(
                      child: Text(
                        "QR Code",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        Get.back();
                        Get.back();
                        var getPage = Get.find<RootPageController>();
                        getPage.onItemTapped(3);
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                Text(
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
