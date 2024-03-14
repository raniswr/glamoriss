import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glamori/app/data/services/api_services.dart';
import 'package:glamori/app/modules/rootPage/controllers/root_page_controller.dart';
import 'package:glamori/app/routes/app_pages.dart';

class OtpRegisterController extends GetxController {
  TextEditingController otpController = TextEditingController();
  String? fullnameArg;
  String? genderArg;
  String? birthdateArg;
  String? emailArg;
  String? phoneArg;
  String? passwordArg;
  String? addressArg;

  @override
  void onClose() {
    // otpController.dispose(); // Dispose of the controller when the controller is closed

    update();
    super.onClose();
  }

  @override
  void onInit() {
    otpController = TextEditingController();
    Map<String, dynamic>? arguments = Get.arguments;
    var fullname = arguments?['fullname'];
    var gender = arguments?['gender'];
    var birthdate = arguments?['birthdate'];
    var email = arguments?['email'];
    var phone = arguments?['phone'];
    var password = arguments?['password'];
    var address = arguments?['address'];
    print(fullname);
    fullnameArg = fullname;
    genderArg = gender;
    birthdateArg = birthdate;
    emailArg = email;
    phoneArg = phone;
    passwordArg = password;
    addressArg = address;
    super.onInit();
  }

  void otpRegister(BuildContext context) async {
    var result = await ApiServices.otpRegister(
      otp: otpController.text,
    );

    if (result != null) {
      Get.toNamed(Routes.rootPage);
      var getPage = Get.find<RootPageController>();
      getPage.onItemTapped(4);
      update();
    }

    update();
  }

  void otpRsend(BuildContext context) async {
    var result = await ApiServices.registerResend(
      fullname: fullnameArg ?? '',
      phone: phoneArg ?? '',
      password: passwordArg ?? '',
      birthdate: birthdateArg ?? '',
      gender: genderArg ?? '',
      email: emailArg ?? '',
      address: addressArg ?? '',
    );
    if (result == true) {
      Get.offAllNamed(
        Routes.RESEND_OTP_PAGE,
        arguments: {
          'fullname': fullnameArg,
          'gender': genderArg,
          'birthdate': birthdateArg,
          'email': emailArg,
          'phone': phoneArg,
          'password': passwordArg,
          'alamat': addressArg,
        },
      );
    }
    update();
  }
}
