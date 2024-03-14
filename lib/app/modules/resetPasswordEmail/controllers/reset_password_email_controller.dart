import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glamori/app/data/services/api_services.dart';
import 'package:glamori/app/routes/app_pages.dart';

class ResetPasswordEmailController extends GetxController {
  TextEditingController emailController = TextEditingController();
  void changePassword(BuildContext context) async {
    var result = await ApiServices.changePasswordOtp(
      email: emailController.text,
    );

    if (result == true) {
      Get.toNamed(
        Routes.resetPasswordPin,
        arguments: {
          'email': emailController.text,
        },
      );
      update();
    }

    update();
  }
}
