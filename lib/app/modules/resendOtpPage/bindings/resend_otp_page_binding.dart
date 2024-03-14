import 'package:get/get.dart';

import '../controllers/resend_otp_page_controller.dart';

class ResendOtpPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResendOtpPageController>(
      () => ResendOtpPageController(),
    );
  }
}
