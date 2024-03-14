import 'package:get/get.dart';

class DetailRedeemPageController extends GetxController {
  String? name;
  String? description;
  String? image;
  @override
  void onInit() {
    Map<String, dynamic>? arguments = Get.arguments;
    var arg1 = arguments?['name'];
    var arg2 = arguments?['description'];
    var arg3 = arguments?['image'];
    name = arg1;
    print("haii $arg1");
    description = arg2;
    image = arg3;
    update();
    super.onInit();
  }
}
