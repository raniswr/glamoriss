import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glamori/app/data/model/model_schedule.dart';
import 'package:glamori/app/data/services/api_services.dart';
import 'package:glamori/app/data/services/user_services.dart';
import 'package:glamori/core/themes/colors.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class TreatmentPagesController extends GetxController {
  ApiServices apiServices = ApiServices();
  ScheduleModel? schedule;
  bool isLoading = false;
  List<String> dateAppoinment = [
    '1',
    '3',
    '7',
    '21',
    '4',
  ];
  List<String> hariAppoinment = [
    '1 Hari Lagi',
    '3 Hari Lagi',
    '7 Hari Lagi',
    '21 Hari Lagi',
    'Riwayat',
  ];

  int currentData = 0;
  today() async {
    var dataLogin = await UserService.find.getLocalUser();
    if (dataLogin != null) {
      schedule = await apiServices.getScheduleToday(UserService.find.user?.id ?? '');
    }
  }

  setCurrentData(int val) async {
    print("setCurrentData: $val");
    currentData = val;
    isLoading = true;
    update();
    if (val == 0) {
      var dataLogin = await UserService.find.getLocalUser();
      if (dataLogin != null) {
        schedule = await apiServices.getScheduleData(
          id: UserService.find.user?.id ?? '',
          filter: "today",
        );
      }
    } else if (val == 1) {
      schedule = await apiServices.getScheduleData(
        id: UserService.find.user?.id ?? '',
        filter: "3days",
      );
    } else if (val == 2) {
      schedule = await apiServices.getScheduleData(
        id: UserService.find.user?.id ?? '',
        filter: "7days",
      );
    } else if (val == 3) {
      schedule = await apiServices.getScheduleData(
        id: UserService.find.user?.id ?? '',
        filter: "21days",
      );
    } else if (val == 4) {
      schedule = await apiServices.getScheduleHistory(UserService.find.user?.id ?? "");
    }
    isLoading = false;
    update();
  }

  List<String> itemsTreatment = ['Semua', 'On-site Appointment', 'Virtual Appointment'];
  String? selectedItemTreatment;

  setTreatment(value) async {
    selectedItemTreatment = value;
    update();
    if (value == 'On-site Appointment') {
      schedule = await apiServices.getScheduleType(type: false, idUser: UserService.find.user?.id ?? "");
      update();
    } else if (value == 'Virtual Appointment') {
      schedule = await apiServices.getScheduleType(type: true, idUser: UserService.find.user?.id ?? "");
      update();
    } else if (value == 'Semua') {
      schedule = await apiServices.getScheduleType(idUser: UserService.find.user?.id ?? "");
      update();
    }
  }

  TextEditingController dateTreatmentController = TextEditingController();

  Future<void> selectDateTreatment(BuildContext context) async {
    DateTime now = DateTime.now();
    DateTime lastDate = DateTime(now.year + 3, now.month, now.day, 23, 59, 59);

    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(1900),
      lastDate: lastDate,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: AppColors.yellow,
            colorScheme: const ColorScheme.light(primary: AppColors.yellow),
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );

    if (picked != null) {
      // var dataLogin = await UserService.find.getLocalUser();

      init(date: picked, idUser: UserService.find.user?.id ?? "");
      dateTreatmentController.text = "${picked.day}-${picked.month}-${picked.year}";
    }
  }

  init({DateTime? date, String? idUser}) async {
    dateTreatmentController.clear();
    try {
      schedule = await apiServices.getScheduleType(date: date, idUser: idUser);
      update();
    } catch (_) {}
  }

  textDate(context) async {
    if (dateTreatmentController.text.isEmpty) {
      selectDateTreatment(context);
      update();
    } else {
      dateTreatmentController.clear();
      schedule = await apiServices.getScheduleType(idUser: UserService.find.user?.id ?? "");
      update();
    }
  }

  initToday() async {
    dateTreatmentController.clear();
    try {
      var dataLogin = await UserService.find.getLocalUser();
      if (dataLogin != null) {
        schedule = await apiServices.getScheduleToday(UserService.find.user?.id ?? '');
      }
      update();
    } catch (_) {}
  }

  String dateFormat(String? date) {
    final f = DateFormat('E, dd MMM yyyy');
    final adjustedDate = (DateTime.tryParse(date ?? '') ?? DateTime.now()).add(Duration(hours: 7));
    return f.format(adjustedDate);
  }

  String timeFormat(String? date) {
    initializeDateFormatting('id_ID', null);
    final f = DateFormat('HH:mm a', 'id_ID');
    final adjustedTime = (DateTime.tryParse(date ?? '') ?? DateTime.now()).add(Duration(hours: 7));
    return f.format(adjustedTime);
  }
}
