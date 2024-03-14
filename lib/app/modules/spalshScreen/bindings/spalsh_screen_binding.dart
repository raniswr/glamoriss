import 'package:get/get.dart';

import '../controllers/spalsh_screen_controller.dart';

class SpalshScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SpalshScreenController>(
      SpalshScreenController(),
    );
  }
}
