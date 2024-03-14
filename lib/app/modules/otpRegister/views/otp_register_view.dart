import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:glamori/app/routes/app_pages.dart';
import 'package:glamori/core/assets.dart';
import 'package:glamori/core/themes/colors.dart';
import 'package:glamori/core/themes/style.dart';

import '../controllers/otp_register_controller.dart';

class OtpRegisterView extends GetView<OtpRegisterController> {
  const OtpRegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OtpRegisterController>(builder: (controller) {
      return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            centerTitle: true,
            title: ExtendedImage.asset(
              Assets.logo,
              width: 150,
              fit: BoxFit.fill,
            ),
            backgroundColor: AppColors.white,
            leading: IconButton(
              icon: SvgPicture.asset(
                Assets.icBack,
              ),
              onPressed: () {
                Get.toNamed(Routes.registerPage);
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'We have sent an OTP on your email ${controller.emailArg}',
                  style: AppStyle.styleTextBody15(),
                  textAlign: TextAlign.center,
                ).marginSymmetric(horizontal: 15).marginOnly(top: 40),
                PinCodeFields(
                  length: 6,
                  fieldBorderStyle: FieldBorderStyle.square,
                  responsive: true,
                  fieldHeight: 50.0,
                  fieldWidth: 40.0,
                  borderWidth: 1.0,
                  activeBorderColor: AppColors.primary,
                  activeBackgroundColor: AppColors.yellowSoft,
                  borderRadius: BorderRadius.circular(10.0),
                  keyboardType: TextInputType.number,
                  autoHideKeyboard: false,
                  fieldBackgroundColor: AppColors.inputColor,
                  borderColor: AppColors.inputColor,
                  controller: controller.otpController,
                  textStyle: AppStyle.styleTextBody22(fontWeight: FontWeight.bold),
                  onComplete: (output) {
                    // Your logic with pin code
                  },
                ).marginSymmetric(horizontal: 20).marginSymmetric(vertical: 30),
                ElevatedButton(
                  onPressed: () {
                    controller.otpRegister(context);
                  },
                  style: AppStyle.styleButton(borderRadius: 23, width: 800),
                  child: Text(
                    'Verify',
                    style: AppStyle.styleTextBody16(colorText: AppColors.white),
                  ),
                ).marginSymmetric(horizontal: 20),
                GestureDetector(
                  onTap: () {
                    controller.otpRsend(context);
                  },
                  child: Text(
                    'Resend OTP',
                    style: AppStyle.styleTextBody14(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ).marginOnly(top: 30),
                ),
                SizedBox(
                  height: 30,
                )
              ],
            ),
          ));
    });
  }
}
