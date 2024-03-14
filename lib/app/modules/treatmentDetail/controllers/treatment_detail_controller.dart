import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glamori/app/data/model/model_schedule.dart';
import 'package:glamori/core/themes/colors.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class TreatmentDetailController extends GetxController {
  Color colorPrimary = AppColors.blue;
  Color colorSecondary = AppColors.blueSoft;

  Data? detail;

  @override
  void onReady() {
    try {
      Map<String, dynamic>? arguments = Get.arguments;
      detail = arguments?['detail'] as Data?;

      if (detail?.isVirtual == true) {
        colorPrimary = AppColors.blue;
        colorSecondary = AppColors.blueSoft;
      } else {
        colorPrimary = AppColors.yellow;
        colorSecondary = AppColors.yellowSoft;
      }
      update();
    } catch (_) {}
    super.onReady();
  }

  String dateFormat() {
    final f = DateFormat('E, dd MMM yyyy');
    return f.format(DateTime.tryParse(detail?.scheduleDate ?? '') ?? DateTime.now());
  }

  String timeFormat(String? date) {
    initializeDateFormatting('id_ID', null);
    final f = DateFormat('HH:mm a', 'id_ID');
    final adjustedTime = (DateTime.tryParse(date ?? '') ?? DateTime.now()).add(Duration(hours: 7));
    return f.format(adjustedTime);
  }
}
