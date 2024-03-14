import 'package:get/get.dart';
import 'package:glamori/app/data/model/model_redeem.dart';
import 'package:glamori/app/data/model/model_redeemed.dart';
import 'package:glamori/app/data/services/api_services.dart';
import 'package:glamori/app/data/services/user_services.dart';

class VoucherPageController extends GetxController {
  @override
  void onReady() async {
    var dataLogin = await UserService.find.getLocalUser();

    if (dataLogin != null) {
      getRedeem(UserService.find.user?.id ?? '');
      update();
    }
    seletectedVouchers = null;
    update();
    super.onReady();
  }

  ModelRedeemed? allRedeemed;
  DocsVoucher? seletectedVouchers;
  getRedeem(String id) async {
    var data = await ApiServices().getRedeemed(id);
    if (data != null) {
      allRedeemed = data;
      update();
    }
  }

  onchange(doc) {
    seletectedVouchers = doc;
    update();
  }
}
