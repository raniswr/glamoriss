import 'package:get/get.dart';
import 'package:glamori/app/data/model/model_detail_product.dart';
import 'package:glamori/app/data/services/user_services.dart';
import 'package:glamori/app/routes/app_pages.dart';
import 'package:glamori/utils/sqlite_helper.dart';
import 'package:intl/intl.dart';

class KeranjangPageController extends GetxController {
  bool isAllChecked = false;
  List<ModelDetailProduct> carts = [];
  List<ModelDetailProduct> cartsPengiriman = [];
  int? count;

  @override
  void onReady() async {
    getCart();
    super.onReady();
  }

  void checkListAll(bool? value) async {
    isAllChecked = value ?? false;
    update();

    var sqlHelper = await SqlLiteHelper.instance.cartTable;
    await sqlHelper.updateCheckedAllProduct(isAllChecked ? 1 : 0);

    getCart();
  }

  void updateCheckboxValue(String id, int check) async {
    var sqlHelper = await SqlLiteHelper.instance.cartTable;
    var result = await sqlHelper.updateCheckedProduct(id, check);

    if (result == 1) {
      getCart();
    }
    update();
  }

  int getCheckedItemCount() {
    return carts.where((item) => item.checked == 1).length;
  }

  getCart() async {
    var sqlHelper = await SqlLiteHelper.instance.cartTable;
    carts = await sqlHelper.getAllCart();

    print('hello ${carts.length}');
    update();
  }

  getCartCheck() async {
    var sqlHelper = await SqlLiteHelper.instance.cartTable;
    cartsPengiriman = await sqlHelper.getCheckedCart();
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

  updateQty(String id, int qty) async {
    var sqlHelper = await SqlLiteHelper.instance.cartTable;
    var result = await sqlHelper.updateQtyProduct(id, qty);
    if (result == 1) {
      getCart();
    }
  }

  delete() async {
    var sqlHelper = await SqlLiteHelper.instance.cartTable;
    await sqlHelper.deleteCartProduct();
  }

  deleteCart() async {
    await delete();
    getCart();
    Get.back();
  }

  goToPengiriman() async {
    await getCartCheck();

    Get.toNamed(Routes.pengirimanPage, arguments: {'product': cartsPengiriman});
  }
}

class CheckboxItem {
  bool value;
  CheckboxItem({required this.value});
}
