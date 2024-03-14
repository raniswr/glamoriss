import 'package:get/get.dart';

import '../controllers/lokasi_page_controller.dart';

class LokasiPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LokasiPageController>(
      () => LokasiPageController(),
    );
  }
}
