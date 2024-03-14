import 'package:get/get.dart';
import 'package:glamori/app/data/model/model_detail_product.dart';
import 'package:glamori/app/data/services/api_services.dart';
import 'package:glamori/app/data/services/user_services.dart';
import 'package:glamori/utils/sqlite_helper.dart';
import 'package:intl/intl.dart';

class DetailBelanjaPageController extends GetxController {
  ModelDetailProduct? detailProduct;
  String? imageUrl;
  bool? isLogin;
  getDetailProduct(String id) async {
    var data = await ApiServices().getDetailProduct(id);
    detailProduct = data;
    update();
  }

  String formatPrice(int productPrice) {
    final formatter = NumberFormat.currency(
      symbol: 'Rp',
      decimalDigits: 0,
      locale: 'id_ID',
    );
    return formatter.format(productPrice);
  }

  @override
  void onInit() async {
    print("onInit started");
    Map<String, dynamic>? arguments = Get.arguments;
    var arg1 = arguments?['productId'];
    var arg2 = arguments?['productImage'];
    imageUrl = arg2;
    super.onInit();
  }

  @override
  void onReady() async {
    Map<String, dynamic>? arguments = Get.arguments;
    var arg1 = arguments?['productId'];
    var arg2 = arguments?['productImage'];
    imageUrl = arg2;
    await getDetailProduct(arg1);
    var dataLogin = await UserService.find.getLocalUser();
    if (dataLogin != null) {
      isLogin = UserService.find.user?.isLogin;
      print(isLogin);
    }
    update();
    super.onReady();
  }

  List<ModelDetailProduct> carts = [];
  getCart() async {
    var sqlHelper = await SqlLiteHelper.instance.cartTable;
    carts = await sqlHelper.getAllCart();
    print('hello ${carts.length}');
    update();
  }
}
