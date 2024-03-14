import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:glamori/app/data/model/model_redeemed.dart';
import 'package:glamori/app/modules/pengirimanPage/controllers/pengiriman_page_controller.dart';
import 'package:glamori/core/assets.dart';
import 'package:glamori/core/themes/colors.dart';
import 'package:glamori/core/themes/style.dart';

import '../controllers/voucher_page_controller.dart';

class VoucherPageView extends GetView<VoucherPageController> {
  const VoucherPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.secondary,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.secondary,
          title: Text(
            'Voucher',
            textAlign: TextAlign.center,
            style: AppStyle.styleTextBody18(fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: SvgPicture.asset(
              Assets.icBack,
            ),
            onPressed: () {
              Get.back(result: {
                'voucher': null,
              });
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: const AnimatedBottomBar(),
        body: GetBuilder<VoucherPageController>(builder: (controller) {
          return ListView.builder(
              itemCount: controller.allRedeemed?.data?.docs?.length ?? 0,
              primary: true,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                var doc = controller.allRedeemed?.data?.docs?[index];
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
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
                  child: RadioListTile<DocsVoucher?>(
                    title: Text(
                      controller.allRedeemed?.data?.docs?[index].name ?? '',
                      style: AppStyle.styleTextBody20(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      controller.allRedeemed?.data?.docs?[index].name ?? '',
                      style: AppStyle.styleTextBody15(),
                    ),
                    value: doc,
                    groupValue: controller.seletectedVouchers,
                    onChanged: (value) {
                      controller.onchange(doc);
                    },
                  ),
                ).marginSymmetric(horizontal: 20, vertical: 10);
              });
        }));
  }
}

class AnimatedBottomBar extends StatelessWidget {
  const AnimatedBottomBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VoucherPageController>(builder: (controller) {
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
              const SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (controller.seletectedVouchers != null) {
                      Get.back(result: {
                        'voucher': [controller.seletectedVouchers],
                      });
                      var pengirimanController = Get.find<PengirimanPageController>();
                      pengirimanController.pointRedeem(false);
                    } else {
                      const SizedBox.shrink();
                    }
                  },
                  child: Container(
                    height: 40,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: controller.seletectedVouchers != null ? AppColors.primary : AppColors.inactiveIconColor,
                    ),
                    child: Center(
                      child: Text(
                        'Pakai',
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
