import 'package:get/get.dart';
import 'package:glamori/app/data/model/model_get_profile.dart';
import 'package:glamori/app/data/services/api_services.dart';
import 'package:glamori/app/data/services/user_services.dart';

class MembershipLevelController extends GetxController {
  //TODO: Implement MembershipLevelController

  ModelGetProfile? users;
  getProfile(String id) async {
    var data = await ApiServices().getProfile(id);
    if (data != null) {
      users = data;
      update();
    }
  }

  @override
  void onReady() async {
    var dataLogin = await UserService.find.getLocalUser();
    if (dataLogin != null) {
      getProfile(UserService.find.user?.id ?? '');
    }
  }
}
