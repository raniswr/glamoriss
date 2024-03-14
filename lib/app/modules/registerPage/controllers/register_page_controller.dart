import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glamori/app/data/services/api_services.dart';
import 'package:glamori/app/modules/rootPage/controllers/root_page_controller.dart';
import 'package:glamori/app/routes/app_pages.dart';
import 'package:glamori/core/themes/colors.dart';
import 'package:intl/intl.dart';

class RegisterPageController extends GetxController {
  List<String> items = ['Perempuan', 'Laki-Laki'];

  // Your selected item
  String? selectedItem;
  TextEditingController nameController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool passwordVisible = true;
  TextEditingController passwordKonfirmasiController = TextEditingController();
  bool passwordKonfirmasiVisible = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  passwordVisibility() {
    passwordVisible = !passwordVisible;
    update();
  }

  passwordKonfirmasiVisibility() {
    passwordKonfirmasiVisible = !passwordKonfirmasiVisible;
    update();
  }

  void register(BuildContext context) async {
    var result = await ApiServices.register(
      fullname: nameController.text,
      phone: phoneController.text,
      password: passwordController.text,
      birthdate: dateController.text,
      gender: selectedItem == 'Perempuan' ? 'perempuan' : 'laki-laki',
      email: emailController.text,
      address: alamatController.text,
    );
    Get.toNamed(
      Routes.OTP_REGISTER,
      arguments: {
        'fullname': nameController.text,
        'gender': selectedItem == 'Perempuan' ? 'perempuan' : 'laki-laki',
        'birthdate': dateController.text,
        'email': emailController.text,
        'phone': phoneController.text,
        'address': alamatController.text,
        'password': passwordController.text,
      },
    );
    if (result == true) {
      Get.toNamed(
        Routes.OTP_REGISTER,
        arguments: {
          'fullname': nameController.text,
          'gender': selectedItem == 'Perempuan' ? 'perempuan' : 'laki-laki',
          'birthdate': dateController.text,
          'email': emailController.text,
          'phone': phoneController.text,
          'password': passwordController.text,
        },
      );
      // var getPage = Get.find<RootPageController>();
      // getPage.onItemTapped(4);
      update();
    }

    update();
  }

  Future<void> selectDate(BuildContext context) async {
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
          child: child!,
        );
      },
    );
    if (picked != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      dateController.text = formattedDate;
    }
  }

  setKelamin(value) {
    selectedItem = value;
    update();
  }

  void validatePasswordConfirmation(String value) {
    // You can add additional logic here if needed
    if (value != passwordController.text) {
      update(); // Ensure that the UI gets updated
    }
  }

  @override
  void onInit() {
    passwordVisible = false;
    passwordKonfirmasiVisible = false;
    super.onInit();
    update();
  }
}
