import 'package:get/get.dart';
import 'package:glamori/app/data/model/model_article.dart';
import 'package:intl/intl.dart';

class ArticlePageController extends GetxController {
  String? title;
  String? description;
  String? image;
  String? date;

  late String videoId;

  @override
  void onInit() {
    super.onInit();
    Map<String, dynamic>? arguments = Get.arguments;
    var arg1 = arguments?['title'];
    var arg2 = arguments?['description'];
    var arg3 = arguments?['image'];
    var arg4 = arguments?['videoUrl'];
    var arg5 = arguments?['date'];
    title = arg1;
    description = arg2;
    image = arg3;
    date = arg5;
  }

  String formatDate(String? inputDate) {
    if (inputDate == null || inputDate.isEmpty) {
      return '';
    }

    // Assuming your inputDate is in the format 'yyyy-MM-ddTHH:mm:ss'
    DateTime date = DateTime.parse(inputDate);
    // print(date);

    // Format the date without time and seconds
    String formattedDate = DateFormat('dd-MM-yyyy').format(date);

    // Return the formatted date as a string
    return formattedDate;
  }
}
