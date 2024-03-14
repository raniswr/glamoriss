import 'package:get/get.dart';
import 'package:glamori/app/data/services/user_services.dart';
import 'package:glamori/app/data/stirage_method.dart';

class LokasiPageController extends GetxController {
  @override
  void onReady() async {
    var dataLokasi = await UserService.find.getLocationUser();
    if (dataLokasi == 'JAKARTA') {
      selectedIndex = 0;
      update();
    } else {
      selectedIndex = 1;
      update();
    }
    super.onReady();
  }

  // SingingCharacter? character = SingingCharacter.lafayette;
  onchange(value) async {
    selectedIndex = value;

    update();
  }

  List<String> itemTitles = [
    'JAKARTA',
    'LAMPUNG',
  ];

  List<String> itemAlamat = [
    'Jl. Jandral Sudirman No.6 150 RT 03 RW 03 Kel. Gayang',
    'Jl. Diponegoro No. 156 Tanjung Karang Pusat Kota Bandar Lampung, 35118 Lampung. 0721252867',
  ];

  int? selectedIndex;

  pilih() async {
    await StorageMethod.saveLokasi(itemTitles[selectedIndex ?? 1]);

    var dataLokasi = await UserService.find.getLocationUser();
    if (dataLokasi != null) {
      print('hai${dataLokasi}');
    }
    Get.back(result: {
      'lokasi': dataLokasi,
    });
  }
}
