// ignore_for_file: deprecated_member_use

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glamori/app/modules/rootPage/controllers/root_page_controller.dart';
import 'package:glamori/app/routes/app_pages.dart';
import 'package:glamori/core/assets.dart';
import 'package:glamori/core/themes/colors.dart';
import 'package:glamori/core/themes/style.dart';

import '../controllers/treatment_pages_controller.dart';

class TreatmentPagesView extends GetView<TreatmentPagesController> {
  const TreatmentPagesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RootPageController>(builder: (controller) {
      return Scaffold(
        backgroundColor: AppColors.secondary,
        appBar: AppBar(
          backgroundColor: AppColors.secondary,
          centerTitle: true,
          title: Text(
            'Treatment',
            textAlign: TextAlign.center,
            style: AppStyle.styleTextBody18(fontWeight: FontWeight.bold),
          ),
          automaticallyImplyLeading: false,
        ),
        body: GetBuilder<TreatmentPagesController>(
            init: TreatmentPagesController(),
            builder: (controllerTreatment) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: SizedBox(
                        height: 80,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ListView.separated(
                              itemCount: controllerTreatment.dateAppoinment.length,
                              separatorBuilder: (context, index) => const SizedBox(
                                width: 10,
                              ),
                              shrinkWrap: true,
                              primary: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    controllerTreatment.setCurrentData(index);
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          color: controllerTreatment.currentData == index ? AppColors.yellowSoft : Colors.white,
                                          boxShadow: const [
                                            BoxShadow(
                                              color: AppColors.grey,
                                              spreadRadius: 0.2,
                                              blurRadius: 1,
                                              offset: Offset(0, 1),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            controllerTreatment.dateAppoinment[index] != '4'
                                                ? Text(
                                                    controllerTreatment.dateAppoinment[index],
                                                    textAlign: TextAlign.center,
                                                    style: AppStyle.styleTextBody22(
                                                      fontWeight: FontWeight.bold,
                                                      colorText: controllerTreatment.currentData == index ? AppColors.yellow : AppColors.textBlack,
                                                    ),
                                                  )
                                                : SvgPicture.asset(
                                                    Assets.icRiwayat,
                                                    color: controllerTreatment.currentData == index ? AppColors.yellow : AppColors.textBlack,
                                                    width: 30,
                                                  ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        controllerTreatment.hariAppoinment[index],
                                        textAlign: TextAlign.center,
                                        style: AppStyle.styleTextBody10(
                                          fontWeight: FontWeight.bold,
                                          colorText: controllerTreatment.currentData == index ? AppColors.yellow : AppColors.textBlack,
                                        ),
                                      ).marginOnly(top: 10),
                                    ],
                                  ),
                                );
                              },
                            ),
                            // SizedBox(
                            //   height: 90,
                            //   child: Column(
                            //     children: [
                            //       Container(
                            //         width: 55,
                            //         height: 50,
                            //         decoration: BoxDecoration(
                            //           borderRadius: BorderRadius.circular(15),
                            //           color: Colors.white,
                            //           boxShadow: const [
                            //             BoxShadow(
                            //               color: AppColors.grey,
                            //               spreadRadius: 0.2,
                            //               blurRadius: 1,
                            //               offset: Offset(0, 1),
                            //             ),
                            //           ],
                            //         ),
                            //         child: Column(
                            //           mainAxisAlignment: MainAxisAlignment.center,
                            //           crossAxisAlignment: CrossAxisAlignment.center,
                            //           children: [
                            //             SvgPicture.asset(
                            //               Assets.icRiwayat,
                            //               color: AppColors.textBlack,
                            //               width: 40,
                            //             ),
                            //           ],
                            //         ),
                            //       ),
                            //       Text(
                            //         'Riwayat',
                            //         textAlign: TextAlign.center,
                            //         style: AppStyle.styleTextBody10(
                            //           fontWeight: FontWeight.bold,
                            //         ),
                            //       ).marginOnly(top: 10),
                            //     ],
                            //   ),
                            // ).marginOnly(left: 10),
                          ],
                        ),
                      ),
                    ),
                    controllerTreatment.currentData == 4
                        ? Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 45,
                                  decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(15), border: Border.all(color: AppColors.inputColor)),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      isExpanded: true,
                                      hint: const Text(
                                        'Semua',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: AppColors.textBlack,
                                        ),
                                      ),
                                      iconStyleData: const IconStyleData(
                                        icon: Icon(
                                          Icons.keyboard_arrow_down_outlined,
                                          color: AppColors.textBlack,
                                        ),
                                        iconSize: 14,
                                        iconEnabledColor: Colors.yellow,
                                        iconDisabledColor: Colors.grey,
                                      ),
                                      items: controllerTreatment.itemsTreatment
                                          .map((String item) => DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: const TextStyle(
                                                    fontSize: 11,
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                      value: controllerTreatment.selectedItemTreatment,
                                      onChanged: (String? value) {
                                        controllerTreatment.setTreatment(value);
                                      },
                                      buttonStyleData: const ButtonStyleData(
                                        padding: EdgeInsets.symmetric(horizontal: 16),
                                        height: 40,
                                        width: double.infinity,
                                      ),
                                      menuItemStyleData: const MenuItemStyleData(
                                        height: 40,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 45,
                                width: 130,
                                child: TextField(
                                  decoration: AppStyle.inputDecorationFloatingTreatment(
                                    "Tanggal",
                                    suffixIcon: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: GestureDetector(
                                          onTap: () {
                                            controllerTreatment..textDate(context);
                                          },
                                          child: controllerTreatment.dateTreatmentController.text.isEmpty
                                              ? SvgPicture.asset(
                                                  Assets.icDate,
                                                  color: AppColors.textBlack,
                                                  width: 20,
                                                  height: 20,
                                                )
                                              : const Icon(
                                                  Icons.close,
                                                  color: AppColors.textBlack,
                                                  size: 20,
                                                )),
                                    ),
                                  ),
                                  onChanged: (value) {},
                                  controller: controllerTreatment.dateTreatmentController,
                                  readOnly: true,
                                ),
                              ).marginOnly(left: 20)
                            ],
                          ).marginSymmetric(horizontal: 20)
                        : const SizedBox.shrink(),
                    controllerTreatment.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : controllerTreatment.schedule?.data?.isEmpty == true
                            ? SvgPicture.asset(
                                controllerTreatment.currentData != 4 ? Assets.imNotTreatment : Assets.imNotHistory,
                                width: 300,
                              )
                            : ListView.builder(
                                itemCount: controllerTreatment.schedule?.data?.length ?? 0,
                                primary: false,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  var item = controllerTreatment.schedule?.data?[index];

                                  return GestureDetector(
                                    onTap: () {
                                      Get.toNamed(Routes.treatmentVirtualPage, arguments: {'detail': item});
                                    },
                                    child: Container(
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
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: item?.isVirtual == true ? AppColors.blueSoft : AppColors.yellowSoft,
                                            ),
                                            child: Column(
                                              children: [
                                                SvgPicture.asset(
                                                  item?.isVirtual == true ? Assets.icVideo : Assets.icOnsite,
                                                  width: 90,
                                                ),
                                              ],
                                            ).marginAll(10),
                                          ).marginSymmetric(horizontal: 20),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    controllerTreatment.dateFormat(item?.scheduleDate),
                                                    style: AppStyle.styleTextBody16(fontWeight: FontWeight.w600, colorText: item?.isVirtual == true ? AppColors.blue : AppColors.yellow),
                                                    textAlign: TextAlign.start,
                                                  ).marginSymmetric(vertical: 5),
                                                  Container(
                                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(20),
                                                        color: item?.isVirtual == true ? AppColors.blueSoft : AppColors.yellowSoft,
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          item?.status == 'upcoming'
                                                              ? 'Upcoming'
                                                              : item?.status == 'completed'
                                                                  ? 'Completed'
                                                                  : '',
                                                          style: AppStyle.styleTextBody12(fontWeight: FontWeight.w600, colorText: item?.isVirtual == true ? AppColors.blue : AppColors.yellow),
                                                        ),
                                                      )),
                                                ],
                                              ).marginSymmetric(vertical: 5),
                                              Text(
                                                controllerTreatment.timeFormat(item?.scheduleDate ?? ''),
                                                style: AppStyle.styleTextBody14(fontWeight: FontWeight.w600),
                                              ).marginOnly(bottom: 5),
                                              Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20),
                                                  color: item?.isVirtual == true ? AppColors.blueSoft : AppColors.yellowSoft,
                                                ),
                                                child: Text(
                                                  item?.isVirtual == true ? 'Virtual Appointment' : 'On-Site Appointment',
                                                  textAlign: TextAlign.center,
                                                  style: AppStyle.styleTextBody12(fontWeight: FontWeight.w600),
                                                ),
                                              ).marginOnly(bottom: 10),
                                              Row(
                                                children: [
                                                  Icon(Icons.person, color: item?.isVirtual == true ? AppColors.blue : AppColors.yellow, size: 17),
                                                  Text(
                                                    item?.patient?.fullname ?? '',
                                                    style: AppStyle.styleTextBody12(),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      ' - ${item?.patient?.memberId ?? ''}',
                                                      style: AppStyle.styleTextBody12(fontWeight: FontWeight.w600),
                                                      maxLines: 1,
                                                      textAlign: TextAlign.start,
                                                    ),
                                                  ),
                                                ],
                                              ).marginSymmetric(vertical: 5),
                                              Row(
                                                children: [
                                                  Icon(Icons.person, color: item?.isVirtual == true ? AppColors.blue : AppColors.yellow, size: 17),
                                                  Expanded(
                                                    child: Text(
                                                      item?.doctor?.fullname ?? '',
                                                      style: AppStyle.styleTextBody12(),
                                                      textAlign: TextAlign.start,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ).marginSymmetric(vertical: 10, horizontal: 25),
                                        ],
                                      ).marginSymmetric(vertical: 20),
                                    ).marginSymmetric(horizontal: 20, vertical: 10),
                                  );
                                },
                              ),
                    const SizedBox(height: 120),
                  ],
                ),
              );
            }),
      );
    });
  }
}
