import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glamori/app/data/services/api_services.dart';
import 'package:glamori/app/modules/rootPage/controllers/root_page_controller.dart';
import 'package:glamori/app/routes/app_pages.dart';

class ResendOtpPageController extends GetxController {
  late TextEditingController otpController;
  String? fullnameArg;
  String? genderArg;
  String? birthdateArg;
  String? emailArg;
  String? phoneArg;
  String? passwordArg;
  String? alamatArg;
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
    var address = arguments?['alamat'];
    print(fullname);
    fullnameArg = fullname;
    genderArg = gender;
    birthdateArg = birthdate;
    emailArg = email;
    phoneArg = phone;
    passwordArg = password;
    alamatArg = address;
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
}
