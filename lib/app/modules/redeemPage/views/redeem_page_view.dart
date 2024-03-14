import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glamori/app/data/services/user_services.dart';
import 'package:glamori/app/routes/app_pages.dart';
import 'package:glamori/core/assets.dart';
import 'package:glamori/core/themes/colors.dart';
import 'package:glamori/core/themes/style.dart';
import '../controllers/redeem_page_controller.dart';
import 'package:qr_flutter/qr_flutter.dart';

class RedeemPageView extends GetView<RedeemPageController> {
  const RedeemPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Membership Point',
            textAlign: TextAlign.center,
            style: AppStyle.styleTextBody18(fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: SvgPicture.asset(
              Assets.icBack,
            ),
            onPressed: () {
              Get.toNamed(Routes.rootPage);
            },
          ),
        ),
        backgroundColor: AppColors.secondary,
        body: GetBuilder<RedeemPageController>(builder: (controller) {
          return SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                await controller.getRedeem(UserService.find.user?.id ?? '');
                await controller.getRedeemed(UserService.find.user?.id ?? '');
                await controller.getProfile(UserService.find.user?.id ?? '');
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          Assets.icBronzeMember,
                          width: 55,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Your level',
                              style: AppStyle.styleTextBody12(),
                            ),
                            Text(
                              '${controller.users?.data?.memberLevel == 'silver' ? 'Silver' : controller.users?.data?.memberLevel == 'gold' ? 'Gold' : 'Bronze'} Member',
                              style: AppStyle.styleTextBody14(fontWeight: FontWeight.bold),
                            )
                          ],
                        ).marginOnly(left: 15)
                      ],
                    ).marginSymmetric(horizontal: 20, vertical: 10),
                    Container(
                            width: double.infinity,
                            height: 96,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: AppColors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: AppColors.grey,
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Membership Points',
                                  style: AppStyle.styleTextBody14(),
                                ).marginOnly(top: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '${controller.users?.data?.point ?? 0}',
                                          style: AppStyle.styleTextBody32(fontWeight: FontWeight.w600),
                                        ).marginOnly(right: 10),
                                        const Icon(
                                          Icons.favorite,
                                          color: AppColors.primary,
                                          size: 30,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      // width: double.infinity,
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              showModalBottomSheet<void>(
                                                context: context,
                                                isScrollControlled: true,
                                                // transitionAnimationController: AnimationController(
                                                //   vsync: Scaffold.of(context),
                                                //   duration: Duration(milliseconds: 1000),
                                                // ),
                                                builder: (BuildContext context) {
                                                  return Container(
                                                    height: 500,
                                                    decoration: const BoxDecoration(
                                                      color: AppColors.bgBottomSheet,
                                                      borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(20.0),
                                                        topRight: Radius.circular(20.0),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        SvgPicture.asset(
                                                          Assets.icBottomSheet,
                                                          width: 40,
                                                        ).marginSymmetric(vertical: 10),
                                                        Text(
                                                          'Detail',
                                                          style: AppStyle.styleTextBody14(fontWeight: FontWeight.bold),
                                                        ),
                                                        Center(
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: <Widget>[
                                                              Container(
                                                                width: double.infinity,
                                                                height: 320,
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
                                                                child: SingleChildScrollView(
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Text(
                                                                        '1. Poin :',
                                                                        style: AppStyle.styleTextBody14(fontWeight: FontWeight.bold),
                                                                      ).marginSymmetric(vertical: 10),
                                                                      const CustomBulletTitle(
                                                                        bulletColor: AppColors.textBlack,
                                                                        text: 'Setiap pembelian minimal 100k akan mendapatkan 1 point',
                                                                      ),
                                                                      const CustomBulletTitle(
                                                                        bulletColor: AppColors.textBlack,
                                                                        text: 'Jika dikonversikan 1 poin bernilai Rp 2.500',
                                                                      ),
                                                                      Text(
                                                                        '2. Hadiah :',
                                                                        style: AppStyle.styleTextBody14(fontWeight: FontWeight.bold),
                                                                      ).marginSymmetric(vertical: 10),
                                                                      const CustomBulletTitle(
                                                                        bulletColor: AppColors.textBlack,
                                                                        text: 'Poin yang dikonversikan dapat dijadikan potongan harga',
                                                                      ),
                                                                      Text(
                                                                        '3. Masa Berlaku Poin:',
                                                                        style: AppStyle.styleTextBody14(fontWeight: FontWeight.bold),
                                                                      ).marginSymmetric(vertical: 10),
                                                                      const CustomBulletTitle(
                                                                        bulletColor: AppColors.textBlack,
                                                                        text: 'Poin tidak memiliki masa berlaku artinya poin bisa dipakai sampai kapanpun',
                                                                      ),
                                                                    ],
                                                                  ).marginAll(20),
                                                                ),
                                                              ).marginAll(20),
                                                              ElevatedButton(
                                                                onPressed: () {
                                                                  Navigator.of(context).pop();
                                                                },
                                                                style: AppStyle.styleButton(borderRadius: 23, width: 800),
                                                                child: Text(
                                                                  'Keluar',
                                                                  style: AppStyle.styleTextBody16(colorText: AppColors.white),
                                                                ),
                                                              ).marginSymmetric(horizontal: 20),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 35,
                                                  width: 70,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(20),
                                                    color: AppColors.primary,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      'Detail',
                                                      style: AppStyle.styleTextBody11(colorText: AppColors.white),
                                                    ),
                                                  ),
                                                ).marginOnly(right: 13, left: 10),
                                              ],
                                            ),
                                          ).marginOnly(right: 10),
                                        ],
                                      ),
                                    )
                                  ],
                                ).marginAll(5),
                              ],
                            ).marginOnly(left: 10))
                        .marginSymmetric(horizontal: 20, vertical: 10),
                    // Container(
                    //   height: 500,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(23),
                    //     color: AppColors.white,
                    //     boxShadow: const [
                    //       BoxShadow(
                    //         color: AppColors.grey,
                    //         spreadRadius: 1,
                    //         blurRadius: 2,
                    //         offset: Offset(0, 2),
                    //       ),
                    //     ],
                    //   ),
                    //   child: Column(
                    //     children: [
                    //       TabBar(
                    //         indicatorColor: AppColors.primary,
                    //         labelColor: AppColors.primary,
                    //         labelStyle: AppStyle.styleTextBody18(),
                    //         unselectedLabelColor: AppColors.inactiveIconColor,
                    //         unselectedLabelStyle: AppStyle.styleTextBody18(colorText: AppColors.inactiveIconColor),
                    //         tabs: const [
                    //           Tab(
                    //             child: Text('Redeem'),
                    //           ),
                    //           Tab(
                    //             child: Text('Redeemed'),
                    //           ),
                    //         ],
                    //         onTap: (index) {
                    //           if (index == 1) {
                    //             // Tab "Redeemed" is clicked
                    //             controller.isRedeemed.value = true;
                    //           } else {
                    //             // Tab "Redeem" is clicked
                    //             controller.isRedeemed.value = false;
                    //           }
                    //         },
                    //       ),
                    //       const Expanded(
                    //         child: TabBarView(
                    //           physics: BouncingScrollPhysics(),
                    //           children: <Widget>[
                    //             RedeemItem(),
                    //             RedeemedItem(),
                    //           ],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ).marginSymmetric(horizontal: 13).marginOnly(top: 20, bottom: 50),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class RedeemItem extends StatelessWidget {
  const RedeemItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RedeemPageController>(builder: (controller) {
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            children: [
              controller.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : controller.allRedeem?.data?.docs?.length != null
                      ? ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.allRedeem?.data?.docs?.length ?? 0,
                          primary: false,
                          itemBuilder: (context, index) {
                            var myPoint = controller.users?.data?.point?.toInt();
                            var pointNeed = controller.allRedeem?.data?.docs?[index].point?.toInt();

                            return Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: AppColors.white,
                                      // boxShadow: const [
                                      //   BoxShadow(
                                      //     color: AppColors.grey,
                                      //     spreadRadius: 0.2,
                                      //     blurRadius: 0.5,
                                      //     offset: Offset(0, 0.2),
                                      //   ),
                                      // ],
                                      border: Border.all(
                                        // Add this line
                                        color: AppColors.greyContainer,
                                        width: 0.5,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.allRedeem?.data?.docs?[index].name ?? '',
                                          style: AppStyle.styleTextBody16(fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          controller.allRedeem?.data?.docs?[index].description ?? '',
                                          style: AppStyle.styleTextBody14(),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            if (myPoint != null && pointNeed != null) {
                                              if (myPoint > pointNeed) {
                                                showAlertDialog(context, controller.allRedeem?.data?.docs?[index].sId ?? '');
                                              }
                                            }
                                          },
                                          child: Stack(
                                            children: [
                                              Container(
                                                height: 35,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20),
                                                  color: myPoint != null && pointNeed != null && myPoint > pointNeed ? AppColors.primary : AppColors.greyContainer,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Gunakan ${controller.allRedeem?.data?.docs?[index].point}',
                                                      style: AppStyle.styleTextBody14(
                                                          colorText: myPoint != null && pointNeed != null && myPoint >= pointNeed ? AppColors.grey : AppColors.inactiveIconColor),
                                                    ),
                                                    Icon(
                                                      Icons.favorite,
                                                      color: myPoint != null && pointNeed != null && myPoint >= pointNeed ? AppColors.white : AppColors.inactiveIconColor,
                                                      size: 18,
                                                    ),
                                                  ],
                                                ),
                                              ).marginSymmetric(vertical: 10),
                                              myPoint != null && pointNeed != null && myPoint > pointNeed
                                                  ? SizedBox.shrink()
                                                  : Positioned(
                                                      bottom: 20,
                                                      left: 30,
                                                      right: 30,
                                                      child: SvgPicture.asset(
                                                        Assets.icLock,
                                                      ),
                                                    )
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              Get.toNamed(Routes.detailRedeemPage, arguments: {
                                                'name': controller.allRedeem?.data?.docs?[index].name,
                                                'description': controller.allRedeem?.data?.docs?[index].description,
                                                'image': controller.allRedeem?.data?.docs?[index].image,
                                              });
                                            },
                                            child: Container(
                                                height: 35,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20),
                                                  border: Border.all(color: AppColors.primary, width: 1),
                                                  color: AppColors.white,
                                                ),
                                                child: Text(
                                                  'Detail',
                                                  textAlign: TextAlign.center,
                                                  style: AppStyle.styleTextBody14(colorText: AppColors.primary),
                                                ).marginOnly(top: 5))),
                                      ],
                                    ).marginAll(20))
                                .marginAll(5);
                          },
                        )
                      : SizedBox.shrink(),
            ],
          ),
        ),
      );
    });
  }
}

class RedeemedItem extends StatelessWidget {
  const RedeemedItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RedeemPageController>(builder: (controller) {
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            children: [
              controller.isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : controller.allRedeemed?.data?.docs?.length != null
                      ? ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.allRedeemed?.data?.docs?.length ?? 0,
                          primary: false,
                          itemBuilder: (context, index) {
                            return Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: AppColors.white,
                                border: Border.all(
                                  color: AppColors.greyContainer,
                                  width: 0.5,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.allRedeemed?.data?.docs?[index].name ?? '',
                                    style: AppStyle.styleTextBody16(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    controller.allRedeemed?.data?.docs?[index].name ?? '',
                                    style: AppStyle.styleTextBody14(),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showAlertDialogBarcode(context, controller.allRedeemed?.data?.docs?[index].voucherId);
                                    },
                                    child: Container(
                                      height: 35,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: AppColors.primary,
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Show Barcode',
                                          style: AppStyle.styleTextBody14(colorText: AppColors.grey),
                                        ),
                                      ),
                                    ).paddingSymmetric(vertical: 10),
                                  ),
                                ],
                              ).paddingAll(20),
                            ).marginAll(5);
                          },
                        )
                      : SizedBox.shrink(),
            ],
          ),
        ),
      );
    });
  }
}

showAlertDialog(BuildContext context, String idReward) {
  AlertDialog alert = AlertDialog(
    backgroundColor: AppColors.white,
    surfaceTintColor: Colors.transparent,
    content: Text(
      "Yakin Ingin Menukarkan Poin Anda dengan Reward Ini?",
      textAlign: TextAlign.center,
      style: AppStyle.styleTextBody16(fontWeight: FontWeight.w600),
    ),
    actions: [
      GetBuilder<RedeemPageController>(builder: (controller) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                        height: 40,
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
                        ))).marginOnly(right: 5)),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  controller.claimReward(idReward);
                },
                style: AppStyle.styleButton(borderRadius: 18),
                child: Text(
                  'Ya',
                  style: AppStyle.styleTextBody16(colorText: AppColors.white),
                ),
              ),
            )
          ],
        );
      }),
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
                  "Untuk Redeem Silahkan Scan QR Code ini",
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
