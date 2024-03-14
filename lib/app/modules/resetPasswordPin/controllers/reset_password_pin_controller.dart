import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glamori/app/data/services/api_services.dart';
import 'package:glamori/app/routes/app_pages.dart';

class ResetPasswordPinController extends GetxController {
  TextEditingController otpController = TextEditingController();
  String? emailArg;
  void otpChangePassword(BuildContext context) async {
    var result = await ApiServices.otpChangePassword(
      otp: otpController.text,
    );

    if (result == true) {
      // Get.toNamed(Routes.rootPage);
      // var getPage = Get.find<RootPageController>();
      // getPage.onItemTapped(4);
      Get.toNamed(Routes.rootPage);
      update();
    }

    update();
  }

  void changePassword(BuildContext context) async {
    var result = await ApiServices.changePasswordOtp(
      email: emailArg ?? '',
    );

    if (result == true) {
      Get.toNamed(Routes.resetPasswordPin);
      update();
    }

    update();
  }

  @override
  void onInit() {
    otpController = TextEditingController();
    Map<String, dynamic>? arguments = Get.arguments;

    var email = arguments?['email'];

    emailArg = email;

    super.onInit();
  }
}
