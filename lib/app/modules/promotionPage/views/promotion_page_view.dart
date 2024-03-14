import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:glamori/app/modules/rootPage/controllers/root_page_controller.dart';
import 'package:glamori/app/routes/app_pages.dart';
import 'package:glamori/core/assets.dart';
import 'package:glamori/core/themes/colors.dart';
import 'package:glamori/core/themes/style.dart';
import '../controllers/promotion_page_controller.dart';

class PromotionPageView extends GetView<PromotionPageController> {
  const PromotionPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.secondary,
        title: Text(
          'Promosi',
          textAlign: TextAlign.center,
          style: AppStyle.styleTextBody18(fontWeight: FontWeight.w600),
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
      body: GetBuilder<PromotionPageController>(builder: (controller) {
        return SingleChildScrollView(
          child: Column(
            children: [
              IntrinsicHeight(
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
                        controller.ModelPromotiion?.title ?? '',
                        style: AppStyle.styleTextBody16(fontWeight: FontWeight.bold),
                      ),
                      Image.network(
                        controller.ModelPromotiion?.image ?? '',
                        width: double.infinity,
                        height: 150,
                        fit: BoxFit.cover,
                      ).marginSymmetric(vertical: 15),
                      Text(
                        controller.ModelPromotiion?.description ?? '',
                        style: AppStyle.styleTextBody14(),
                      ),
                    ],
                  ).marginAll(20),
                ).marginAll(20),
              ),
              controller.ModelPromotiion?.product != null
                  ? GestureDetector(
                      onTap: () {
                        Get.toNamed(
                          Routes.detailBelanjaPage,
                          arguments: {
                            'productId': controller.ModelPromotiion?.product?.sId,
                          },
                        );
                      },
                      child: Container(
                          height: 40,
                          width: 210,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: AppColors.primary,
                          ),
                          child: Center(
                            child: Text(
                              'Dapatkan Promosinya!',
                              style: AppStyle.styleTextBody16(colorText: AppColors.white),
                            ),
                          )).marginOnly(top: 20, bottom: 10),
                    )
                  : SizedBox.shrink()
            ],
          ),
        );
      }),
    );
  }
}
