import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:glamori/app/routes/app_pages.dart';
import 'package:glamori/core/assets.dart';
import 'package:glamori/core/themes/colors.dart';
import 'package:glamori/core/themes/style.dart';

import '../controllers/notifikasi_page_controller.dart';

class NotifikasiPageView extends GetView<NotifikasiPageController> {
  const NotifikasiPageView({Key? key}) : super(key: key);
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
      body: GetBuilder<NotifikasiPageController>(builder: (controller) {
        return ListView.builder(
            shrinkWrap: true,
            itemCount: controller.allNotif?.data?.docs?.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Get.toNamed(
                    Routes.NOTIFIKASI_DETAIL,
                    arguments: {
                      'title': controller.allNotif?.data?.docs?[index].title,
                      'description': controller.allNotif?.data?.docs?[index].description,
                    },
                  );
                },
                child: Column(
                  children: [
                    ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              controller.allNotif?.data?.docs?[index].title ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppStyle.styleTextBody15(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            controller.formatDate(controller.allNotif?.data?.docs?[index].date ?? ''),
                            style: AppStyle.styleTextBody12(fontWeight: FontWeight.bold),
                          ).marginOnly(left: 5),
                        ],
                      ),
                      subtitle: Text(
                        controller.allNotif?.data?.docs?[index].description ?? '',
                        maxLines: 1,
                        style: AppStyle.styleTextBody15(),
                      ),
                    ),
                    Divider(
                      thickness: 0.1,
                    ),
                  ],
                ),
              );
            });
      }),
    );
  }
}
