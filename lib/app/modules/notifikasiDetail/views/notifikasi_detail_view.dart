import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:glamori/core/assets.dart';
import 'package:glamori/core/themes/colors.dart';
import 'package:glamori/core/themes/style.dart';

import '../controllers/notifikasi_detail_controller.dart';

class NotifikasiDetailView extends GetView<NotifikasiDetailController> {
  const NotifikasiDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.secondary,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.secondary,
          title: Text(
            'Notifikasi',
            textAlign: TextAlign.center,
            style: AppStyle.styleTextBody18(fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: SvgPicture.asset(
              Assets.icBack,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: GetBuilder<NotifikasiDetailController>(builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.title ?? '',
                style: AppStyle.styleTextBody16(fontWeight: FontWeight.bold),
              ).marginSymmetric(vertical: 10),
              Text(
                controller.description ?? '',
                style: AppStyle.styleTextBody15(),
              ),
            ],
          ).marginSymmetric(horizontal: 20, vertical: 20);
        }));
  }
}
