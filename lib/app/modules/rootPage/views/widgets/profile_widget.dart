import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glamori/app/data/services/user_services.dart';
import 'package:glamori/app/modules/rootPage/controllers/root_page_controller.dart';
import 'package:glamori/app/routes/app_pages.dart';
import 'package:glamori/core/assets.dart';
import 'package:glamori/core/themes/colors.dart';
import 'package:glamori/core/themes/style.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: AppColors.secondary,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: GetBuilder<RootPageController>(builder: (controller) {
          return RefreshIndicator(
            onRefresh: () async {
              await controller.getProfile(UserService.find.user?.id ?? "");
            },
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const ProfileImage(),
                  const SizedBox(height: 16),
                  const NameProfile(),
                  CarouselSlider(
                    carouselController: controller.carouselController,
                    options: CarouselOptions(
                      height: 200.0,
                      viewportFraction: 1.0,
                      onPageChanged: controller.onPageChanged,
                    ),
                    items: controller.profileUrls.asMap().entries.map((entry) {
                      int index = entry.key;

                      return Builder(
                        builder: (BuildContext context) {
                          return GestureDetector(
                            onTap: () {
                              controller.nextPage();
                            },
                            child: Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25),
                                    image: DecorationImage(
                                      image: AssetImage(controller.profileUrls[index]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ).marginSymmetric(horizontal: 15),
                                controller.currentIndex == 1
                                    ? const SizedBox.shrink()
                                    : Positioned(
                                        left: 30,
                                        right: 30,
                                        bottom: 10,
                                        child: Column(
                                          children: [
                                            Text(
                                              controller.users?.data?.fullname ?? '',
                                              style: AppStyle.styleTextBody18(fontWeight: FontWeight.w600, colorText: AppColors.white),
                                            ),
                                            Text(
                                              controller.users?.data?.memberId ?? '',
                                              style: AppStyle.styleTextBody18(colorText: AppColors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                controller.currentIndex == 1 && controller.profileUrls[index] == controller.profileUrls[1]
                                    ? Positioned(
                                        right: 70,
                                        child: SizedBox(
                                          width: 200,
                                          child: QrImageView(
                                            data: controller.users?.data?.memberId ?? '',
                                            version: QrVersions.auto,
                                          ),
                                        ),
                                      )
                                    : const SizedBox.shrink()
                              ],
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ).marginOnly(top: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: controller.profileUrls.map((url) {
                      int index = controller.profileUrls.indexOf(url);
                      return Container(
                        width: 10.0,
                        height: 10.0,
                        margin: const EdgeInsets.symmetric(horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: controller.currentIndex == index ? AppColors.yellow : AppColors.yellowSoft,
                        ),
                      );
                    }).toList(),
                  ).marginOnly(top: 5),
                  GestureDetector(
                    onTap: () async {
                      await controller.initEdit();

                      // ignore: use_build_context_synchronously
                      showModalBottomSheet<void>(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: AppColors.white,
                        builder: (BuildContext context) {
                          return GetBuilder<RootPageController>(
                              init: RootPageController(),
                              builder: (controller) {
                                return SizedBox(
                                  height: 590,
                                  child: SingleChildScrollView(
                                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                    child: Form(
                                      key: formKey,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: SvgPicture.asset(
                                              Assets.icBottomSheet,
                                              width: 40,
                                            ).marginSymmetric(vertical: 10),
                                          ),
                                          Center(
                                            child: Text(
                                              'Edit Profil',
                                              style: AppStyle.styleTextBody16(fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Text(
                                            'Nama',
                                            style: AppStyle.styleTextBody14(),
                                          ).marginOnly(left: 25),
                                          TextField(
                                            decoration: AppStyle.inputDecorationFloating("Nama Lengkap",
                                                suffixIcon: const Icon(
                                                  Icons.edit,
                                                  color: AppColors.gray,
                                                  size: 20,
                                                )),
                                            controller: controller.namaController,
                                          ).marginSymmetric(horizontal: 20),
                                          Text(
                                            'Email',
                                            style: AppStyle.styleTextBody14(),
                                          ).marginOnly(left: 25, top: 10),
                                          TextField(
                                            decoration: AppStyle.inputDecorationFloating("Email",
                                                suffixIcon: Icon(
                                                  Icons.edit,
                                                  color: AppColors.gray,
                                                  size: 17,
                                                )),
                                            controller: controller.emailController,
                                          ).marginSymmetric(horizontal: 20),
                                          Text(
                                            'No Telepon',
                                            style: AppStyle.styleTextBody14(),
                                          ).marginOnly(left: 25, top: 10),
                                          TextField(
                                            decoration: AppStyle.inputDecorationFloating("No Telepon",
                                                suffixIcon: Icon(
                                                  Icons.edit,
                                                  color: AppColors.gray,
                                                  size: 17,
                                                )),
                                            controller: controller.teleponController,
                                          ).marginSymmetric(horizontal: 20),
                                          Text(
                                            'Jenis Kelamin',
                                            style: AppStyle.styleTextBody14(),
                                          ).marginOnly(left: 25, top: 10),
                                          Container(
                                            decoration: BoxDecoration(color: AppColors.inputColor, borderRadius: BorderRadius.circular(15)),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton2<String>(
                                                isExpanded: true,
                                                hint: const Text(
                                                  'Jenis Kelamin',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: AppColors.textGrey,
                                                  ),
                                                ),
                                                iconStyleData: const IconStyleData(
                                                  icon: Icon(
                                                    Icons.keyboard_arrow_down_outlined,
                                                    color: AppColors.textLightGrey,
                                                  ),
                                                  iconSize: 14,
                                                  iconEnabledColor: Colors.yellow,
                                                  iconDisabledColor: Colors.grey,
                                                ),
                                                items: controller.items
                                                    .map((String item) => DropdownMenuItem<String>(
                                                          value: item,
                                                          child: Text(
                                                            item,
                                                            style: const TextStyle(
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ))
                                                    .toList(),
                                                value: controller.selectedItem,
                                                onChanged: (String? value) {
                                                  controller.setKelamin(value);
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
                                          ).marginSymmetric(horizontal: 20),
                                          Text(
                                            'Tanggal Lahir',
                                            style: AppStyle.styleTextBody14(),
                                          ).marginOnly(left: 25, top: 10),
                                          TextField(
                                            decoration: AppStyle.inputDecorationFloating(
                                              "Tanggal Lahir",
                                              suffixIcon: Padding(
                                                padding: const EdgeInsets.all(15.0),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    controller.selectDate(context);
                                                  },
                                                  child: SvgPicture.asset(
                                                    Assets.icDate,
                                                    width: 20,
                                                    height: 20,
                                                    color: AppColors.yellow,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            controller: controller.dateController,
                                            readOnly: true,
                                          ).marginSymmetric(horizontal: 20),
                                          Text(
                                            'Alamat',
                                            style: AppStyle.styleTextBody14(),
                                          ).marginOnly(left: 25).marginOnly(top: 20),
                                          TextField(
                                            decoration: AppStyle.inputDecorationFloating("Alamat"),
                                            controller: controller.alamatController,
                                            maxLines: 3,
                                          ).marginSymmetric(horizontal: 20),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                  child: GestureDetector(
                                                      onTap: () {
                                                        showAlertDialog(context, "Yakin Ingin Keluar?", context);
                                                      },
                                                      child: Container(
                                                          height: 40,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(18),
                                                            border: Border.all(color: AppColors.primary, width: 1),
                                                            color: Colors.transparent,
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              'Keluar',
                                                              style: AppStyle.styleTextBody16(),
                                                            ),
                                                          ))).marginOnly(right: 5)),
                                              Expanded(
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    showAlertDialogEdit(context, "Yakin ingin mengubah data di edit profile?");
                                                  },
                                                  style: AppStyle.styleButton(borderRadius: 18),
                                                  child: Text(
                                                    'Perbarui',
                                                    style: AppStyle.styleTextBody16(colorText: AppColors.white),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ).marginAll(20).marginOnly(top: 10),
                                        ],
                                      ).marginOnly(top: 20),
                                    ),
                                  ),
                                );
                              });
                        },
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                Assets.icEdit,
                              ),
                              Text(
                                'Edit Profil',
                                style: AppStyle.styleTextBody16(),
                              ).marginOnly(left: 5),
                            ],
                          ),
                          SvgPicture.asset(
                            Assets.icArrow,
                          ),
                        ],
                      ).marginAll(10),
                    ).marginSymmetric(horizontal: 20, vertical: 10),
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet<void>(
                        context: context,
                        backgroundColor: AppColors.white,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return GetBuilder<RootPageController>(
                              init: RootPageController(),
                              builder: (controller) {
                                return SingleChildScrollView(
                                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                  child: Form(
                                    key: formKey,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: SvgPicture.asset(
                                            Assets.icBottomSheet,
                                            width: 40,
                                          ).marginSymmetric(vertical: 10),
                                        ),
                                        Center(
                                          child: Text(
                                            'Ubah Kata Sandi',
                                            style: AppStyle.styleTextBody16(fontWeight: FontWeight.bold),
                                          ),
                                        ).marginSymmetric(vertical: 5),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Kata Sandi Lama',
                                              style: AppStyle.styleTextBody14(),
                                            ).marginOnly(left: 25, top: 10),
                                            TextField(
                                              decoration: AppStyle.inputDecorationFloating(
                                                "Kata Sandi Lama",
                                                suffixIcon: GestureDetector(
                                                  onTap: () {
                                                    controller.passwordVisibility();
                                                  },
                                                  child: controller.passwordVisible
                                                      ? Padding(
                                                          padding: const EdgeInsets.all(15.0),
                                                          child: SvgPicture.asset(
                                                            Assets.icInvisiblePass,
                                                            width: 20,
                                                            height: 20,
                                                            color: AppColors.yellow,
                                                          ))
                                                      : Padding(
                                                          padding: const EdgeInsets.all(15.0),
                                                          child: SvgPicture.asset(
                                                            Assets.icVisiblePass,
                                                            color: AppColors.yellow,
                                                          ),
                                                        ),
                                                ),
                                              ),
                                              controller: controller.passwordController,
                                              obscureText: controller.passwordVisible,
                                            ).marginSymmetric(horizontal: 20),
                                            Text(
                                              'Kata Sandi Baru',
                                              style: AppStyle.styleTextBody14(),
                                            ).marginOnly(left: 25, top: 10),
                                            TextFormField(
                                              decoration: AppStyle.inputDecorationFloating(
                                                "Kata Sandi Baru",
                                                suffixIcon: GestureDetector(
                                                  onTap: () {
                                                    controller.passwordKataSandiBaruVisibility();
                                                  },
                                                  child: controller.passwordKataSandiBaruVisible
                                                      ? Padding(
                                                          padding: const EdgeInsets.all(15.0),
                                                          child: SvgPicture.asset(
                                                            Assets.icInvisiblePass,
                                                            width: 20,
                                                            height: 20,
                                                            color: AppColors.yellow,
                                                          ))
                                                      : Padding(
                                                          padding: const EdgeInsets.all(15.0),
                                                          child: SvgPicture.asset(
                                                            Assets.icVisiblePass,
                                                            color: AppColors.yellow,
                                                          ),
                                                        ),
                                                ),
                                              ),
                                              validator: (val) {
                                                if (val?.isEmpty == true) return 'Mohon isi password';
                                                return null;
                                              },
                                              controller: controller.passwordKataSandiBaruController,
                                              obscureText: controller.passwordKataSandiBaruVisible,
                                            ).marginSymmetric(horizontal: 20),
                                            Text(
                                              'Konfirmasi Sandi Baru',
                                              style: AppStyle.styleTextBody14(),
                                            ).marginOnly(left: 25, top: 10),
                                            TextFormField(
                                              decoration: AppStyle.inputDecorationFloating(
                                                "Konfirmasi Sandi Baru",
                                                suffixIcon: GestureDetector(
                                                  onTap: () {
                                                    controller.passwordKonfirmasiVisibility();
                                                  },
                                                  child: controller.passwordKonfirmasiVisible
                                                      ? Padding(
                                                          padding: const EdgeInsets.all(15.0),
                                                          child: SvgPicture.asset(
                                                            Assets.icInvisiblePass,
                                                            width: 20,
                                                            height: 20,
                                                            color: AppColors.yellow,
                                                          ))
                                                      : Padding(
                                                          padding: const EdgeInsets.all(15.0),
                                                          child: SvgPicture.asset(
                                                            Assets.icVisiblePass,
                                                            color: AppColors.yellow,
                                                          ),
                                                        ),
                                                ),
                                              ),
                                              validator: (val) {
                                                if (val?.isEmpty == true) return 'Mohon isi konfirmasi password';
                                                if (val != controller.passwordKataSandiBaruController.text) return 'Konfirmasi password salah';
                                                return null;
                                              },
                                              autovalidateMode: AutovalidateMode.onUserInteraction,
                                              onChanged: (v) {
                                                controller.update();
                                              },
                                              controller: controller.passwordKonfirmasiController,
                                              obscureText: controller.passwordKonfirmasiVisible,
                                            ).marginSymmetric(horizontal: 20),
                                          ],
                                        ).marginOnly(top: 10),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                                child: GestureDetector(
                                                    onTap: () {
                                                      showAlertDialog(context, "Yakin ingin Keluar?", context);
                                                    },
                                                    child: Container(
                                                        height: 40,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(18),
                                                          border: Border.all(color: AppColors.primary, width: 1),
                                                          color: Colors.transparent,
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            'Keluar',
                                                            style: AppStyle.styleTextBody16(),
                                                          ),
                                                        ))).marginOnly(right: 5)),
                                            Expanded(
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  if (formKey.currentState?.validate() == true) {
                                                    showAlertDialogChangePassword(context, "Yakin ingin mengubah kata sandi?");
                                                  }
                                                },
                                                style: AppStyle.styleButton(borderRadius: 18),
                                                child: Text(
                                                  'Perbarui',
                                                  style: AppStyle.styleTextBody16(colorText: AppColors.white),
                                                ),
                                              ),
                                            )
                                          ],
                                        ).marginAll(20).marginOnly(top: 10),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                Assets.icPassword,
                              ),
                              Text(
                                'Ubah Kata Sandi',
                                style: AppStyle.styleTextBody16(),
                              ).marginOnly(left: 5),
                            ],
                          ),
                          SvgPicture.asset(
                            Assets.icArrow,
                          ),
                        ],
                      ).marginAll(10),
                    ).marginSymmetric(horizontal: 20),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.faqPage);
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                Assets.icFaq,
                              ),
                              Text(
                                'FAQ',
                                style: AppStyle.styleTextBody16(),
                              ).marginOnly(left: 5),
                            ],
                          ),
                          SvgPicture.asset(
                            Assets.icArrow,
                          ),
                        ],
                      ).marginAll(10),
                    ).marginSymmetric(horizontal: 20, vertical: 10),
                  ),
                  GestureDetector(
                    onTap: () async {
                      showAlertDialogKeluar(context, "Yakin ingin Keluar?");
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                Assets.icKeluar,
                              ),
                              Text(
                                ' Keluar',
                                style: AppStyle.styleTextBody16(),
                              ).marginOnly(left: 5),
                            ],
                          ),
                          SvgPicture.asset(
                            Assets.icArrow,
                          ),
                        ],
                      ).marginAll(10),
                    ).marginSymmetric(horizontal: 20),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (await canLaunch('https://evetechsolution.com/id')) {
                        await launch('https://evetechsolution.com/id');
                      } else {
                        // Handle error, e.g., show an alert
                      }
                    },
                    child: Text(
                      'Powered by Evetech Solution',
                      style: AppStyle.styleTextBody12(colorText: AppColors.gray),
                    ),
                  ).marginOnly(top: 20),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class NameProfile extends StatelessWidget {
  const NameProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RootPageController>(builder: (controller) {
      return Column(
        children: [
          Text(controller.users?.data?.fullname ?? '', style: AppStyle.styleTextBody18(fontWeight: FontWeight.w600)),
          Text(controller.users?.data?.phone ?? '', style: AppStyle.styleTextBody16()),
          Container(
            width: double.infinity,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.yellowSoft,
            ),
            child: Center(
              child: Text(
                controller.users?.data?.email ?? '',
                style: AppStyle.styleTextBody16(fontWeight: FontWeight.w500),
              ),
            ),
          ).marginSymmetric(horizontal: 50, vertical: 5),
          Container(
            width: double.infinity,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.yellowSoft,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ID Member',
                  style: AppStyle.styleTextBody16(fontWeight: FontWeight.w500),
                ),
                Expanded(
                  child: Text(
                    controller.users?.data?.memberId ?? '',
                    maxLines: 1,
                    textAlign: TextAlign.end,
                    style: AppStyle.styleTextBody16(
                      fontWeight: FontWeight.w600,
                      colorText: AppColors.yellow,
                    ),
                  ),
                ),
              ],
            ).marginSymmetric(horizontal: 10),
          ).marginSymmetric(horizontal: 50),
        ],
      );
    });
  }
}

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RootPageController>(builder: (controller) {
      return Column(
        children: [
          Center(
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () async {
                    // ignore: use_build_context_synchronously
                    showModalBottomSheet<void>(
                      context: context,
                      backgroundColor: AppColors.white,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: 150,
                          child: Column(
                            children: [
                              Center(
                                child: SvgPicture.asset(
                                  Assets.icBottomSheet,
                                  width: 40,
                                ).marginSymmetric(vertical: 10),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        'Foto Profil',
                                        style: AppStyle.styleTextBody16(fontWeight: FontWeight.bold),
                                      ),
                                    ).paddingOnly(left: 50),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controller.deleteImage();
                                    },
                                    child: SvgPicture.asset(
                                      Assets.icDelete,
                                      width: 25,
                                    ).marginOnly(right: 20),
                                  )
                                ],
                              ).marginOnly(bottom: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      controller.cameraImage();
                                    },
                                    child: ExtendedImage.asset(
                                      Assets.chooseCamera,
                                      width: 70,
                                      fit: BoxFit.fill,
                                    ).marginOnly(right: 20),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controller.pickImage();
                                    },
                                    child: ExtendedImage.asset(
                                      Assets.chooseGalery,
                                      width: 70,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5.0,
                          spreadRadius: 0.0,
                          offset: Offset(0.0, 2.0),
                        ),
                      ],
                      border: Border.all(
                        color: Colors.white,
                        width: 3.0,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: AppColors.inputColor,
                      backgroundImage: controller.imagePath != null
                          ? Image.file(File(controller.imagePath ?? '')).image
                          : controller.users?.data?.image != null
                              ? Image.network(controller.users?.data?.image ?? '').image
                              : const AssetImage('assets/images/person.png'),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet<void>(
                        context: context,
                        backgroundColor: AppColors.white,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return SizedBox(
                            height: 150,
                            child: Column(
                              children: [
                                Center(
                                  child: SvgPicture.asset(
                                    Assets.icBottomSheet,
                                    width: 40,
                                  ).marginSymmetric(vertical: 10),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          'Foto Profil',
                                          style: AppStyle.styleTextBody16(fontWeight: FontWeight.bold),
                                        ),
                                      ).paddingOnly(left: 50),
                                    ),
                                    SvgPicture.asset(
                                      Assets.icDelete,
                                      width: 25,
                                    ).marginOnly(right: 20)
                                  ],
                                ).marginOnly(bottom: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        controller.cameraImage();
                                      },
                                      child: ExtendedImage.asset(
                                        Assets.chooseCamera,
                                        width: 70,
                                        fit: BoxFit.fill,
                                      ).marginOnly(right: 20),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        controller.pickImage();
                                      },
                                      child: ExtendedImage.asset(
                                        Assets.chooseGalery,
                                        width: 70,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.yellow,
                        border: Border.all(
                          color: Colors.white,
                          width: 2.0,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5.0,
                            spreadRadius: 0.0,
                            offset: Offset(0.0, 2.0),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        size: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ).marginOnly(top: 60),
          ),
        ],
      );
    });
  }
}

showAlertDialog(BuildContext context, String title, BuildContext bottomSheetContext) {
  AlertDialog alert = AlertDialog(
    backgroundColor: AppColors.white,
    surfaceTintColor: Colors.transparent,
    title: SizedBox(
      width: 200,
      child: Text(
        title,
        textAlign: TextAlign.center,
        maxLines: 2,
        style: AppStyle.styleTextBody16(),
      ),
    ),
    actions: [
      GetBuilder<RootPageController>(builder: (controller) {
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
                  Navigator.of(bottomSheetContext).pop();
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

showAlertDialogKeluar(
  BuildContext context,
  String title,
) {
  AlertDialog alert = AlertDialog(
    backgroundColor: AppColors.white,
    surfaceTintColor: Colors.transparent,
    title: Column(
      children: [
        SvgPicture.asset(
          Assets.icLogout,
          width: 120,
        ),
        SizedBox(
          width: 200,
          child: Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: AppStyle.styleTextBody16(),
          ),
        ),
      ],
    ),
    actions: [
      GetBuilder<RootPageController>(builder: (controller) {
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
                onPressed: () async {
                  controller.updateToken(context);
                  Navigator.of(context).pop();
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

showAlertDialogEdit(BuildContext context, String title) {
  AlertDialog alert = AlertDialog(
    backgroundColor: AppColors.white,
    surfaceTintColor: Colors.transparent,
    title: SizedBox(
      width: 200,
      child: Text(
        title,
        textAlign: TextAlign.center,
        maxLines: 2,
        style: AppStyle.styleTextBody16(),
      ),
    ),
    actions: [
      GetBuilder<RootPageController>(builder: (controller) {
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
                onPressed: () async {
                  Navigator.of(context).pop();
                  controller.editProfile(context);
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

showAlertDialogChangePassword(BuildContext context, String title) {
  AlertDialog alert = AlertDialog(
    backgroundColor: AppColors.white,
    surfaceTintColor: Colors.transparent,
    title: SizedBox(
      width: 200,
      child: Text(
        title,
        textAlign: TextAlign.center,
        maxLines: 2,
        style: AppStyle.styleTextBody16(),
      ),
    ),
    actions: [
      GetBuilder<RootPageController>(builder: (controller) {
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
                  controller.changePassword(context);
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
