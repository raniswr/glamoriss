// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:glamori/app/data/services/firebase_messanging.dart';
import 'package:glamori/app/routes/app_pages.dart';
import 'package:glamori/core/themes/theme.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    // LocalNotificationService.initialize(context);
    // FirebaseMessaging.onMessage.listen((event) async {
    //   LocalNotificationService.display(event);
    // });
    // FirebaseMessaging.onMessageOpenedApp.listen((event) {
    //   LocalNotificationService.onNotificationTapBG(event);
    //   // LocalNotificationService.display(event);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "GLAMORI",
      theme: AppTheme().theme(),
      initialRoute: AppPages.initial,
      debugShowCheckedModeBanner: false,
      getPages: AppPages.routes,
      builder: EasyLoading.init(),
    );
  }
}
