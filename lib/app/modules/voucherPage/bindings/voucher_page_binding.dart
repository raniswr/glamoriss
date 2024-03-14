import 'package:get/get.dart';

import '../controllers/voucher_page_controller.dart';

class VoucherPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VoucherPageController>(
      () => VoucherPageController(),
    );
  }
}
