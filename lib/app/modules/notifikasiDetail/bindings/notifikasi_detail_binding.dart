import 'package:get/get.dart';

import '../controllers/notifikasi_detail_controller.dart';

class NotifikasiDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotifikasiDetailController>(
      () => NotifikasiDetailController(),
    );
  }
}
