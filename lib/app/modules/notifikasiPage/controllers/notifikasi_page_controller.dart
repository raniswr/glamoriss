import 'package:get/get.dart';
import 'package:glamori/app/data/model/model_notif.dart';
import 'package:glamori/app/data/services/api_services.dart';
import 'package:glamori/app/data/services/user_services.dart';
import 'package:intl/intl.dart';

class NotifikasiPageController extends GetxController {
  ModelNotif? allNotif;

  getAllNotif(String id) async {
    var data = await ApiServices().getAllNotif(id);
    if (data != null) {
      allNotif = data;
      update();
    }
  }

  String formatDate(String? inputDate) {
    if (inputDate == null || inputDate.isEmpty) {
      return '';
    }

    DateTime date = DateTime.parse(inputDate);

    date = date.toLocal();

    String formattedDate = DateFormat('dd-MM-yyyy').format(date);

    return formattedDate;
  }

  @override
  void onReady() async {
    var dataLogin = await UserService.find.getLocalUser();

    if (dataLogin != null) {
      getAllNotif(UserService.find.user?.id ?? '');
      update();
    }
    update();
    super.onReady();
  }
}
