import 'package:get/get.dart';
import 'package:glamori/app/routes/app_pages.dart';

class SpalshScreenController extends GetxController {
  @override
  void onReady() {
    Future.delayed(const Duration(seconds: 3)).then((value) => Get.offAllNamed(Routes.rootPage));
    update();
    super.onReady();
  }
}
