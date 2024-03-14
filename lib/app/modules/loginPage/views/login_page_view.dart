import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:glamori/app/routes/app_pages.dart';
import 'package:glamori/core/assets.dart';
import 'package:glamori/core/themes/colors.dart';
import 'package:glamori/core/themes/style.dart';

import '../controllers/login_page_controller.dart';

class LoginPageView extends GetView<LoginPageController> {
  const LoginPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: GetBuilder<LoginPageController>(builder: (controller) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: ExtendedImage.asset(
                  Assets.background,
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ExtendedImage.asset(
                      Assets.logo,
                      width: 274,
                      fit: BoxFit.fill,
                    ).marginOnly(top: 80),
                    Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email',
                            style: AppStyle.styleTextBody14(),
                          ).marginOnly(left: 25),
                          TextFormField(
                            decoration: AppStyle.inputDecorationFloating("Email"),
                            controller: controller.phoneController,
                          ).marginSymmetric(horizontal: 20),
                          Text(
                            'Password',
                            style: AppStyle.styleTextBody14(),
                          ).marginOnly(left: 25).marginOnly(top: 20),
                          TextFormField(
                            decoration: AppStyle.inputDecorationFloating(
                              "Password",
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  controller.passwordLoginVisibility();
                                },
                                child: controller.passwordLoginVisible
                                    ? Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: SvgPicture.asset(
                                          Assets.icInvisiblePass,
                                          color: AppColors.yellow,
                                          width: 20,
                                          height: 20,
                                        ))
                                    : Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: SvgPicture.asset(
                                          color: AppColors.yellow,
                                          Assets.icVisiblePass,
                                        ),
                                      ),
                              ),
                            ),
                            controller: controller.passwordLoginController,
                            obscureText: controller.passwordLoginVisible,
                          ).marginSymmetric(horizontal: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.resetPasswordPage);
                                },
                                child: Text(
                                  'Lupa Password?',
                                  style: AppStyle.styleTextBody14(),
                                ),
                              ),
                            ],
                          ).marginOnly(right: 25).marginSymmetric(vertical: 15),
                          ElevatedButton(
                            onPressed: () {
                              if (controller.phoneController.text.isNotEmpty && controller.passwordLoginController.text.isNotEmpty) {
                                controller.login(context);
                              }
                            },
                            style: AppStyle.styleButton(borderRadius: 23, width: 800),
                            child: Text(
                              'Masuk',
                              style: AppStyle.styleTextBody16(colorText: AppColors.white),
                            ),
                          ).marginSymmetric(horizontal: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Belum punya akun? ',
                                style: AppStyle.styleTextBody14(),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.registerPage);
                                },
                                child: Text(
                                  'Daftar',
                                  style: AppStyle.styleTextBody14(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ).marginOnly(top: 40)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
