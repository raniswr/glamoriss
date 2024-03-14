import 'dart:async';

// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:glamori/core/themes/colors.dart';
import 'package:glamori/main_binding.dart';

import 'app.dart';

FutureOr<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..loadingStyle = EasyLoadingStyle.custom
    ..backgroundColor = AppColors.primary
    ..indicatorColor = AppColors.white
    ..maskColor = Colors.yellow
    ..dismissOnTap = false
    ..textColor = AppColors.white
    ..userInteractions = false;
  MainBinding.init();
  runApp(const App());
}
