import 'package:get/get.dart';

import '../controllers/membership_level_controller.dart';

class MembershipLevelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MembershipLevelController>(
      () => MembershipLevelController(),
    );
  }
}
