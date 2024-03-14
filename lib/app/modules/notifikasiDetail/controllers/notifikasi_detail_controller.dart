import 'package:get/get.dart';
import 'package:glamori/app/data/model/model_notif.dart';

class NotifikasiDetailController extends GetxController {
  //TODO: Implement NotifikasiDetailController
  String? title;
  String? description;

  @override
  void onReady() {
    Map<String, dynamic>? arguments = Get.arguments;
    var arg1 = arguments?['title'];
    var arg2 = arguments?['description'];
    title = arg1;
    description = arg2;
    update();
    super.onReady();
  }
}
