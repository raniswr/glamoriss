import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:glamori/app/routes/app_pages.dart';
import 'package:glamori/core/assets.dart';
import 'package:glamori/core/themes/colors.dart';
import 'package:glamori/core/themes/style.dart';

import '../controllers/lokasi_page_controller.dart';

class LokasiPageView extends GetView<LokasiPageController> {
  const LokasiPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.secondary,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.secondary,
          title: Text(
            'Lokasi',
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
        body: GetBuilder<LokasiPageController>(builder: (controller) {
          return ListView.builder(
              itemCount: 2,
              primary: true,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
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
                  child: RadioListTile(
                    value: index,
                    groupValue: controller.selectedIndex,
                    onChanged: (value) {
                      controller.onchange(value);
                    },
                    title: Text(
                      controller.itemTitles[index],
                      style: AppStyle.styleTextBody18(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      controller.itemAlamat[index],
                      style: AppStyle.styleTextBody14(),
                    ),
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
    return GetBuilder<LokasiPageController>(builder: (controller) {
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
                    controller.pilih();
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
                        'Pilih',
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
