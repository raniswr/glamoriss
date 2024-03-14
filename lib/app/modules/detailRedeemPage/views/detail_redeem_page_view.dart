import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glamori/app/routes/app_pages.dart';
import 'package:glamori/core/assets.dart';
import 'package:glamori/core/themes/colors.dart';
import 'package:glamori/core/themes/style.dart';
import '../controllers/detail_redeem_page_controller.dart';

class DetailRedeemPageView extends GetView<DetailRedeemPageController> {
  const DetailRedeemPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.secondary,
        title: Text(
          'Redeem Detail',
          textAlign: TextAlign.center,
          style: AppStyle.styleTextBody18(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: SvgPicture.asset(
            Assets.icBack,
          ),
          onPressed: () {
            Get.toNamed(Routes.redeemPage);
          },
        ),
      ),
      body: IntrinsicHeight(
        child: GetBuilder<DetailRedeemPageController>(builder: (controller) {
          return GestureDetector(
            onTap: () {
              // Get.toNamed(Routes.detailBelanjaPage);
            },
            child: Container(
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    controller.name ?? '',
                    style: AppStyle.styleTextBody16(fontWeight: FontWeight.bold),
                  ),
                  controller.image != null
                      ? ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(14.0),
                            topRight: Radius.circular(14.0),
                            bottomLeft: Radius.circular(14.0),
                            bottomRight: Radius.circular(14.0),
                          ),
                          child: Image.network(
                            controller.image ?? '',
                            fit: BoxFit.cover,
                          ),
                        ).marginSymmetric(vertical: 20)
                      : const SizedBox.shrink(),
                  Text(
                    controller.description ?? '',
                    style: AppStyle.styleTextBody14(),
                  ),
                ],
              ).marginAll(20),
            ).marginAll(20),
          );
        }),
      ),
    );
  }
}
