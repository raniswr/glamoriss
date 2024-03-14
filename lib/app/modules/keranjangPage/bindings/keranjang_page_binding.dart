import 'package:get/get.dart';
import 'package:glamori/app/modules/rootPage/controllers/root_page_controller.dart';

import '../controllers/keranjang_page_controller.dart';

class KeranjangPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<KeranjangPageController>(
      KeranjangPageController(),
    );
  }
}
