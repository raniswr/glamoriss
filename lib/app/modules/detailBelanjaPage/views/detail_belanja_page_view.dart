import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glamori/app/modules/pengirimanPage/views/pengiriman_page_view.dart';
import 'package:glamori/app/routes/app_pages.dart';
import 'package:glamori/core/assets.dart';
import 'package:glamori/core/themes/colors.dart';
import 'package:glamori/core/themes/style.dart';
import 'package:glamori/utils/sqlite_helper.dart';

import '../controllers/detail_belanja_page_controller.dart';

class DetailBelanjaPageView extends GetView<DetailBelanjaPageController> {
  const DetailBelanjaPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.secondary,
        title: Text(
          'Produk Detail',
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
      body: SingleChildScrollView(
        child: GetBuilder<DetailBelanjaPageController>(builder: (controller) {
          var product = controller.detailProduct?.data;
          String? name = controller.detailProduct?.data?.name;
          String? description = controller.detailProduct?.data?.description;
          String? productImage = controller.imageUrl;
          String? productImageNetwork = controller.detailProduct?.data?.image;
          print(productImageNetwork);
          int? price = controller.detailProduct?.data?.price;
          return Column(
            children: [
              // Container(
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(20),
              //     color: AppColors.yellowSoft,
              //   ),
              //   child: Column(
              //     children: [
              productImage != null
                  ? Image.network(
                      productImage,
                      width: 230,
                      height: 230,
                      fit: BoxFit.cover,
                    ).marginSymmetric(vertical: 20)
                  : productImageNetwork != null
                      ? Image.network(
                          productImageNetwork,
                          width: 230,
                          height: 230,
                          fit: BoxFit.cover,
                        ).marginSymmetric(vertical: 20)
                      : const SizedBox.shrink(),
              // ],
              //   ),
              // ).marginSymmetric(horizontal: 20),
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        name ?? '',
                        style: AppStyle.styleTextBody15(fontWeight: FontWeight.w600),
                      ),
                    ),
                    Text(
                      price != null ? controller.formatPrice(price) : '',
                      style: AppStyle.styleTextBody16(fontWeight: FontWeight.w600, colorText: AppColors.yellow),
                    ),
                  ],
                ).marginAll(20),
              ).marginAll(20),
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
                    Text(
                      product != null ? 'Deskripsi' : '',
                      style: AppStyle.styleTextBody15(fontWeight: FontWeight.w600),
                    ).marginOnly(bottom: 5),
                    product != null
                        ? CustomBulletTitle(
                            bulletColor: AppColors.textBlack,
                            text: description ?? '',
                          ).marginOnly(top: 3)
                        : const SizedBox.shrink(),
                    // const CustomBulletTitle(
                    //   bulletColor: AppColors.textBlack,
                    //   text: 'Dipakai pada pagi dan malam hari sebelum penggunaan lotion',
                    // ).marginOnly(top: 3),
                    // const CustomBulletTitle(
                    //   bulletColor: AppColors.textBlack,
                    //   text: 'Membantu agar lotion meresap dengan maksimal',
                    // ),
                  ],
                ).marginAll(20),
              ).marginSymmetric(horizontal: 20),
              const SizedBox(height: 120),
            ],
          );
        }),
      ),
    );
  }
}

class AnimatedBottomBar extends StatelessWidget {
  const AnimatedBottomBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailBelanjaPageController>(builder: (controller) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: controller.detailProduct?.data != null
            ? Container(
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
                child: GetBuilder<DetailBelanjaPageController>(
                  init: DetailBelanjaPageController(),
                  builder: (controller) {
                    return Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            if (controller.detailProduct != null) {
                              var sqlHelper = await SqlLiteHelper.instance.cartTable;
                              var productId = controller.detailProduct?.data?.sId ?? '';
                              var data = await sqlHelper.getCartById(productId);
                              if (controller.isLogin == true) {
                                if (data == null) {
                                  await sqlHelper.insertCart(controller.detailProduct!);
                                  // print(result);
                                  // if (result == 1) {
                                  // ignore: use_build_context_synchronously
                                  CustomToast.showToast(context, "Produk berhasil disimpan ke keranjang");
                                  // Get.toNamed(Routes.keranjangPage);
                                  // }
                                } else {
                                  var result = await sqlHelper.updateQtyProduct(productId, (data.qty ?? 0) + 1);
                                  if (result == 1) {
                                    // ignore: use_build_context_synchronously
                                    CustomToast.showToast(context, "Produk berhasil disimpan ke keranjang");
                                    // Get.toNamed(Routes.keranjangPage);
                                  }
                                }
                              } else {
                                Get.toNamed(Routes.LOGIN_PAGE);
                              }
                            }
                          },
                          child: Container(
                            width: 90,
                            height: 44,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: AppColors.primary, width: 1),
                              color: AppColors.white,
                            ),
                            child: Center(
                                child: SvgPicture.asset(
                              Assets.icShop,
                              width: 40,
                            )),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              showAlertDialogMarketPlace(context, controller.detailProduct?.data?.shopee, controller.detailProduct?.data?.tokped);
                            },
                            style: AppStyle.styleButton(borderRadius: 23),
                            child: Text(
                              'Beli Sekarang',
                              textAlign: TextAlign.center,
                              style: AppStyle.styleTextBody16(colorText: AppColors.white),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              )
            : SizedBox.shrink(),
      );
    });
  }
}

class CustomBulletTitle extends StatelessWidget {
  const CustomBulletTitle({
    Key? key,
    required this.bulletColor,
    required this.text,
  }) : super(key: key);

  final Color bulletColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 3,
          backgroundColor: bulletColor,
        ).marginOnly(top: 5),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 13, color: AppColors.textBlack), // You can customize the style here
          ),
        ),
      ],
    );
  }
}

class CustomToast {
  static void showToast(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (BuildContext context) => Positioned(
        top: 80,
        left: 40,
        right: 40,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: AppColors.yellowSoft,
              border: Border.all(
                color: AppColors.yellow,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textBlack,
                fontSize: 12.0,
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    // Display the toast for 3 seconds
    Future.delayed(const Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }
}

showAlertDialogMarketPlace(BuildContext context, String? linkShopee, String? linkTokped) {
  AlertDialog alert = AlertDialog(
    backgroundColor: AppColors.white,
    surfaceTintColor: Colors.transparent,
    title: Column(
      children: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  "Marketplace",
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
        GetBuilder<DetailBelanjaPageController>(builder: (controller) {
          return Container(
            width: double.infinity,
            height: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ItemStore(
                  title: "Shopee",
                  icon: Assets.icShopee,
                  link: linkShopee ?? 'https://shopee.co.id/glamori_clinic',
                ), // Reduce the left margin
                ItemStore(
                  title: "Tokopedia",
                  icon: Assets.icTokped,
                  link: linkTokped ?? 'https://www.tokopedia.com/glamori-clinic',
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    Get.toNamed(
                      Routes.pengirimanPage,
                      arguments: {
                        'product': [controller.detailProduct],
                      },
                    );
                  },
                  child: const ItemStoreKlinik(
                    title: "Klinik Glamori",
                    icon: Assets.icKlinik,
                  ),
                ),
              ],
            ).marginSymmetric(vertical: 10),
          );
        }),
      ],
    ),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class ItemStoreKlinik extends StatelessWidget {
  const ItemStoreKlinik({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  final String title;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
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
      ),
    );
  }
}
