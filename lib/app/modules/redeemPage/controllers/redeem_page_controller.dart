import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glamori/app/data/model/model_get_profile.dart';
import 'package:glamori/app/data/model/model_redeem.dart';
import 'package:glamori/app/data/model/model_redeemed.dart';
import 'package:glamori/app/data/services/api_services.dart';
import 'package:glamori/app/data/services/user_services.dart';

class RedeemPageController extends GetxController {
  RxBool isRedeemed = false.obs;
  bool isLoading = false;
  @override
  void onReady() async {
    var dataLogin = await UserService.find.getLocalUser();

    if (dataLogin != null) {
      getProfile(UserService.find.user?.id ?? '');
      getRedeem(UserService.find.user?.id ?? '');
      getRedeemed(UserService.find.user?.id ?? '');
      update();
    }
    update();
    super.onReady();
  }

  ModelGetProfile? users;
  getProfile(String id) async {
    var data = await ApiServices().getProfile(id);
    if (data != null) {
      users = data;
      update();
    }
  }

  ModelRedeem? allRedeem;
  getRedeem(String id) async {
    isLoading = true;
    var data = await ApiServices().getRedeem(id);
    if (data != null) {
      allRedeem = data;
      update();
      isLoading = false;
    }
  }

  ModelRedeemed? allRedeemed;
  getRedeemed(String id) async {
    isLoading = true;
    var data = await ApiServices().getRedeemed(id);
    if (data != null) {
      allRedeemed = data;
      update();
      isLoading = false;
    }
  }

  void claimReward(String idReward) async {
    var result = await ApiServices.claimReward(id: UserService.find.user?.id ?? '', reward: idReward);
  }
}
