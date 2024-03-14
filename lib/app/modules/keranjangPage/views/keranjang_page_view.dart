import 'dart:developer';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glamori/core/assets.dart';
import 'package:glamori/core/themes/colors.dart';
import 'package:glamori/core/themes/style.dart';
import '../controllers/keranjang_page_controller.dart';

class KeranjangPageView extends GetView<KeranjangPageController> {
  const KeranjangPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<KeranjangPageController>(
        init: KeranjangPageController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: AppColors.secondary,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: AppColors.secondary,
              title: Text(
                'Keranjang',
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
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            floatingActionButton: const AnimatedBottomBar(),
            body: controller.carts.isEmpty
                ? Center(
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          Assets.imKeranjangKosong,
                          width: 270,
                        ),
                        Text(
                          'Belum ada produk',
                          style: AppStyle.styleTextBody16(fontWeight: FontWeight.bold),
                          maxLines: 3,
                        ).marginSymmetric(vertical: 10),
                        GestureDetector(
                          onTap: () async {
                            // Get.offNamedUntil(Routes.rootPage, (route) => false);
                            // var getPage = Get.isRegistered<RootPageController>() ? Get.find<RootPageController>() : Get.put(RootPageController());
                            // getPage.onItemTapped(2);
                            Get.back();
                          },
                          child: Container(
                            height: 30,
                            width: 220,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: AppColors.primary,
                            ),
                            child: Center(
                              child: Text(
                                'Temukan Produk!',
                                style: AppStyle.styleTextBody16(colorText: AppColors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ).marginOnly(top: 50),
                  )
                : ListView.builder(
                    itemCount: controller.carts.length,
                    primary: true,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final item = controller.carts[index];

                      return CheckboxListTileWidget(
                        checkboxValue: item.checked == 1,
                        isThreeLine: false,
                        onChanged: (bool? value) {
                          controller.updateCheckboxValue(item.data?.sId ?? '', value == true ? 1 : 0);
                        },
                        title: Container(
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
                            child: Row(
                              children: [
                                ExtendedImage.network(
                                  item.data?.image ?? '',
                                  width: 60,
                                  fit: BoxFit.fill,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10),
                                ).marginOnly(right: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        item.data?.name ?? '-',
                                        style: AppStyle.styleTextBody11(fontWeight: FontWeight.bold),
                                        maxLines: 3,
                                      ),
                                      Text(
                                        controller.formatPrice(item.data?.price ?? 0),
                                        style: AppStyle.styleTextBody11(colorText: AppColors.yellow, fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                                QtyButton(
                                  onMin: () {
                                    log("onmin");
                                    var itemQty = (item.qty ?? 0);
                                    controller.updateQty(item.data?.sId ?? '', itemQty > 1 ? itemQty - 1 : 1);
                                  },
                                  onPlus: () {
                                    log("onPlus");
                                    var itemQty = (item.qty ?? 0);
                                    controller.updateQty(item.data?.sId ?? '', itemQty >= 1 ? itemQty + 1 : 1);
                                  },
                                  qty: item.qty.toString(),
                                ).marginOnly(left: 0),
                              ],
                            )),
                      ).marginOnly(bottom: controller.carts.length - 1 == index ? 100 : 0);
                    },
                  ),
          );
        });
  }
}

class AnimatedBottomBar extends StatelessWidget {
  const AnimatedBottomBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<KeranjangPageController>(builder: (controller) {
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
                Row(
                  children: [
                    Checkbox(
                      fillColor: MaterialStatePropertyAll(controller.carts.isEmpty
                          ? AppColors.grey
                          : controller.isAllChecked
                              ? AppColors.yellow
                              : AppColors.grey),
                      activeColor: AppColors.yellow,
                      value: controller.carts.isEmpty ? false : controller.isAllChecked,
                      side: BorderSide.none,
                      onChanged: (bool? value) {
                        controller.checkListAll(value);
                      },
                      visualDensity: VisualDensity.compact,
                    ),
                    Text(
                      'All',
                      style: AppStyle.styleTextBody16(),
                    ),
                  ],
                ).marginOnly(right: 5),
                GestureDetector(
                  onTap: () {
                    controller.carts.isEmpty
                        ? SizedBox.shrink()
                        : controller.getCheckedItemCount() != 0
                            ? showAlertDialog(context)
                            : EasyLoading.showInfo('Harap pilih produk!');
                  },
                  child: Container(
                    width: 53,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17),
                      border: Border.all(color: controller.carts.isEmpty ? AppColors.gray : AppColors.primary, width: 1),
                      color: AppColors.white,
                    ),
                    child: Center(
                        child: SvgPicture.asset(
                      Assets.icDelete,
                      color: controller.carts.isEmpty ? AppColors.gray : AppColors.primary,
                      width: 28,
                    )),
                  ),
                ).marginSymmetric(horizontal: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (controller.carts.isEmpty) {
                        SizedBox.shrink();
                      } else if (controller.getCheckedItemCount() == 0) {
                        EasyLoading.showInfo('Harap pilih product!');
                      } else {
                        controller.goToPengiriman();
                      }
                    },
                    child: Container(
                      height: 40,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: controller.carts.isEmpty ? AppColors.gray : AppColors.primary,
                      ),
                      child: Center(
                        child: Text(
                          'Beli Sekarang',
                          style: AppStyle.styleTextBody16(colorText: AppColors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      );
    });
  }
}

class CheckboxListTileWidget extends StatelessWidget {
  final bool checkboxValue;
  final void Function(bool?)? onChanged;
  final Widget title;
  final bool isThreeLine;

  const CheckboxListTileWidget({
    required this.checkboxValue,
    required this.onChanged,
    required this.title,
    this.isThreeLine = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: checkboxValue,
      onChanged: onChanged,
      side: BorderSide.none,
      fillColor: MaterialStatePropertyAll(checkboxValue ? AppColors.yellow : AppColors.grey),
      title: title,
      activeColor: AppColors.yellow,
      isThreeLine: isThreeLine,
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}

class QtyButton extends StatefulWidget {
  const QtyButton({
    Key? key,
    required this.onMin,
    required this.onPlus,
    required this.qty,
  }) : super(key: key);

  final VoidCallback onMin;
  final VoidCallback onPlus;
  final String qty;

  @override
  // ignore: library_private_types_in_public_api
  _QtyButtonState createState() => _QtyButtonState();
}

class _QtyButtonState extends State<QtyButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: AppColors.yellow.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 15,
            child: GestureDetector(
              onTap: () {
                // Call the onPlus callback
                widget.onMin();
                // Manually update the TextField value
                // _updateTextFieldValue(1);
              },
              child: const CircleAvatar(
                radius: 12,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.remove,
                  size: 12,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 18,
            child: Center(
                child: Text(
              widget.qty,
              style: TextStyle(fontSize: 13),
              textAlign: TextAlign.center,
            )
                // TextField(
                //   controller: widget.controller,
                //   keyboardType: TextInputType.number,
                //   onChanged: (newValue) {},
                //   style: const TextStyle(
                //     fontSize: 12,
                //     color: Colors.black,
                //   ),
                //   textAlign: TextAlign.center,
                //   decoration: const InputDecoration(
                //     border: InputBorder.none,
                //   ),
                // ),
                ),
          ),
          SizedBox(
            width: 15,
            child: GestureDetector(
              onTap: () {
                // Call the onPlus callback
                widget.onPlus();
                // Manually update the TextField value
                // _updateTextFieldValue(1);
              },
              child: const CircleAvatar(
                radius: 12,
                backgroundColor: AppColors.yellow,
                child: Icon(
                  Icons.add,
                  size: 12,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    ).marginOnly(right: 10);
  }

  // Helper function to update the TextField value
  // void _updateTextFieldValue(int increment) {
  //   final currentValue = int.tryParse(widget.controller.text) ?? 0;
  //   final newValue = currentValue + increment;
  //   if (newValue > 0) {
  //     widget.controller.text = newValue.toString();
  //   }
  // }
}

showAlertDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    backgroundColor: AppColors.white,
    surfaceTintColor: Colors.transparent,
    title: SizedBox(
      width: 200,
      child: GetBuilder<KeranjangPageController>(builder: (controller) {
        return Text(
          "Yakin Ingin Menghapus ${controller.getCheckedItemCount()} Produk?",
          textAlign: TextAlign.center,
          maxLines: 2,
          style: AppStyle.styleTextBody16(),
        );
      }),
    ),
    actions: [
      Row(
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
            child: GetBuilder<KeranjangPageController>(
              init: KeranjangPageController(),
              builder: (controller) {
                return ElevatedButton(
                  onPressed: () {
                    controller.deleteCart();
                  },
                  style: AppStyle.styleButton(borderRadius: 18),
                  child: Text(
                    'Ya',
                    style: AppStyle.styleTextBody16(colorText: AppColors.white),
                  ),
                );
              },
            ),
          )
        ],
      ),
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
