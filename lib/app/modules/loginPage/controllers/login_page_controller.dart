// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glamori/app/data/model/model_user.dart';
import 'package:glamori/app/data/services/api_services.dart';
// import 'package:glamori/app/data/services/firebase_messanging.dart';
import 'package:glamori/app/data/services/user_services.dart';
import 'package:glamori/app/data/stirage_method.dart';
import 'package:glamori/app/modules/rootPage/controllers/root_page_controller.dart';
import 'package:glamori/app/routes/app_pages.dart';

class LoginPageController extends GetxController {
  TextEditingController passwordLoginController = TextEditingController();
  bool passwordLoginVisible = true;

  passwordLoginVisibility() {
    passwordLoginVisible = !passwordLoginVisible;
    update();
  }

  TextEditingController phoneController = TextEditingController();

  final RootPageController rootController = Get.find();

  void login(BuildContext context) async {
    // String? tokenReminder = await FirebaseMessaging.instance.getToken();
    String? tokenReminder = '';
    var result = await ApiServices.login(email: phoneController.text, password: passwordLoginController.text, tokenReminder: tokenReminder ?? '');

    if (result != null) {
      if (result.message == "Login Success") {
        var user = ModelUser(
          token: result.data?.accessToken,
          fullname: result.data?.patient?.fullname,
          phone: result.data?.patient?.phone,
          id: result.data?.patient?.sId,
          email: result.data?.patient?.email,
          memberId: result.data?.patient?.memberId,
          patientId: result.data?.patient?.patientId,
          lokasi: 'LAMPUNG',
          isLogin: true,
        );

        await StorageMethod.saveUserToLocal(user);
        rootController.isLogin = true;
        if (rootController.isLogin == true) {
          var dataLogin = await UserService.find.getLocalUser();
          if (dataLogin != null) {
            rootController.getProfile(UserService.find.user?.id ?? '');
            rootController.initPembelian();
          }
        } else {}
        Get.offAllNamed(Routes.rootPage);
        update();
      }
      update();
    }
  }
}
