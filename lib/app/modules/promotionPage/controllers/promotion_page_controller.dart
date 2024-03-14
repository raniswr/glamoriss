import 'package:get/get.dart';
import 'package:glamori/app/data/model/model_promotion.dart';

class PromotionPageController extends GetxController {
  Docs? ModelPromotiion;
  @override
  void onReady() {
    Map<String, dynamic>? arguments = Get.arguments;
    ModelPromotiion = arguments?['promotion'] as Docs;
    update();
    super.onReady();
  }
}
