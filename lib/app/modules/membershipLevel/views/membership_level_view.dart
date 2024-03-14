import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:glamori/app/routes/app_pages.dart';
import 'package:glamori/core/assets.dart';
import 'package:glamori/core/themes/colors.dart';
import 'package:glamori/core/themes/style.dart';
import 'package:intl/intl.dart';

import '../controllers/membership_level_controller.dart';

class MembershipLevelView extends GetView<MembershipLevelController> {
  const MembershipLevelView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.secondary,
          title: Text(
            'Membership Point',
            textAlign: TextAlign.center,
            style: AppStyle.styleTextBody20(fontWeight: FontWeight.bold),
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
        body: SingleChildScrollView(
          child: GetBuilder<MembershipLevelController>(builder: (controller) {
            return Column(
              children: [
                ListTile(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      StatusBar(
                        status: controller.users?.data?.memberLevel == 'gold'
                            ? OrderStatus.gold
                            : controller.users?.data?.memberLevel == 'silver'
                                ? OrderStatus.silver
                                : OrderStatus.bronze,
                      ),
                    ],
                  ),
                ),
                controller.users?.data?.memberLevel == 'silver'
                    ? Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: AppColors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: AppColors.grey,
                              spreadRadius: 0.6,
                              blurRadius: 0.1,
                              offset: Offset(0, 0.4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              Assets.icSilverTitle,
                              width: 90,
                            ).marginOnly(bottom: 10),
                            Text(
                              'Silver member adalah member yang telah melakukan transaksi sampai Rp.100.000.000 di Glamori. Silahkan tukarkan poin ada dengan penawaran menarik dari kami',
                              style: AppStyle.styleTextBody14(),
                            ),
                          ],
                        ).paddingAll(20),
                      ).marginSymmetric(horizontal: 20).marginOnly(bottom: 10)
                    : controller.users?.data?.memberLevel == 'gold'
                        ? Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: AppColors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: AppColors.grey,
                                  spreadRadius: 0.6,
                                  blurRadius: 0.1,
                                  offset: Offset(0, 0.4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  Assets.icGoldTitle,
                                  width: 90,
                                ).marginOnly(bottom: 10),
                                Text(
                                  'Gold member adalah member yang telah melakukan transaksi sampai Rp.200.000.000 di Glamori. Silahkan tukarkan poin ada dengan penawaran menarik dari kami',
                                  style: AppStyle.styleTextBody14(),
                                ),
                              ],
                            ).paddingAll(20),
                          ).marginSymmetric(horizontal: 20).marginOnly(bottom: 10)
                        : Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: AppColors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: AppColors.grey,
                                  spreadRadius: 0.6,
                                  blurRadius: 0.1,
                                  offset: Offset(0, 0.4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  Assets.icBronzeTitle,
                                  width: 90,
                                ).marginOnly(bottom: 10),
                                Text(
                                  'Bronze member adalah member yang telah melakukan transaksi sampai Rp.50.000.000 di Glamori. Silahkan tukarkan poin ada dengan penawaran menarik dari kami',
                                  style: AppStyle.styleTextBody14(),
                                ),
                              ],
                            ).paddingAll(20),
                          ).marginSymmetric(horizontal: 20, vertical: 10),
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
                    children: [
                      Text(
                        'Syarat Dan Ketentuan',
                        style: AppStyle.styleTextBody16(fontWeight: FontWeight.bold),
                      ).marginOnly(bottom: 5),
                      CustomBulletTitle(
                        bulletColor: AppColors.textBlack,
                        text: 'Ketahui metode perhitungan point, cara naik atau turun member level dan ketentuan lainnya',
                      )
                    ],
                  ).paddingAll(20),
                ).marginSymmetric(horizontal: 20).marginOnly(bottom: 40),
              ],
            );
          }),
        ));
  }
}

class StatusBar extends StatelessWidget {
  const StatusBar({Key? key, this.status}) : super(key: key);

  final OrderStatus? status;
  final List<String> titles = const ['Bronze', 'Silver', 'Gold'];

  @override
  Widget build(BuildContext context) {
    var checkedCount = _getCheckedCount(status!!);
    var elements = List<bool>.generate(3, (i) => i < checkedCount);

    return Column(
      children: <Widget>[
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: elements
                  .asMap()
                  .map((index, isChecked) => MapEntry(
                        index,
                        Column(
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 4,
                                  width: index == 1 || index == 2 ? 75 : 40,
                                  color: isChecked ? AppColors.yellow : AppColors.grayLine,
                                ),
                                isChecked
                                    ? SvgPicture.asset(
                                        Assets.icBulletCheck,
                                        width: 23,
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          if (index == 1) {
                                            CustomToast.cancelToast();
                                            CustomToast.showToast(context, index);
                                          } else if (index == 2) {
                                            CustomToast.showToast(context, index);
                                          }
                                        },
                                        child: SvgPicture.asset(
                                          Assets.icBullet,
                                          width: 25,
                                        ),
                                      ),
                                index == 2
                                    ? Container(
                                        height: 4,
                                        width: 35,
                                        color: isChecked ? AppColors.yellow : AppColors.grayLine,
                                      )
                                    : SizedBox.shrink(),
                              ],
                            ),
                          ],
                        ),
                      ))
                  .values
                  .toList(),
            ),
            Center(
              child: SvgPicture.asset(
                Assets.listMemberLevel,
                height: 78,
              ).marginOnly(bottom: 10),
            )
          ],
        ).marginOnly(top: 25),
      ],
    );
  }

  _getCheckedCount(OrderStatus status) {
    switch (status) {
      case OrderStatus.bronze:
        return 1;
      case OrderStatus.silver:
        return 2;
      case OrderStatus.gold:
        return 3;
    }
  }
}

enum OrderStatus { bronze, silver, gold }

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
        ).marginOnly(top: 8),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 14, color: AppColors.textBlack), // You can customize the style here
          ),
        ),
      ],
    );
  }
}

class CustomToast {
  static OverlayEntry? _overlayEntry; // Declare _overlayEntry as nullable

  static void showToast(BuildContext context, int index) {
    final overlay = Overlay.of(context);

    // Remove existing toast if it exists
    cancelToast();

    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => index == 1
          ? Positioned(
              top: 80,
              left: 40,
              right: 40,
              child: Material(
                color: Colors.transparent,
                child: SvgPicture.asset(
                  Assets.icSyaratSilver,
                  width: 220,
                ),
              ),
            )
          : Positioned(
              top: 80,
              right: 40,
              child: Material(
                color: Colors.transparent,
                child: SvgPicture.asset(
                  Assets.icSyaratGold,
                  width: 220,
                ),
              ),
            ),
    );

    overlay.insert(_overlayEntry!);

    // Display the toast for 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      cancelToast(); // Remove the toast after 3 seconds
    });
  }

  static void cancelToast() {
    _overlayEntry?.remove(); // Remove the overlay entry if it exists
    _overlayEntry = null; // Reset the overlay entry
  }
}
