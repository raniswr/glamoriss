// import 'dart:convert';
// import 'dart:developer';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// const DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(
//   onDidReceiveLocalNotification: onDidReceiveLocalNotification,
// );

// onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) async {
//   // display a dialog with the notification details, tap ok to go to another page
//   log(id.toString());
//   log(title ?? "");
//   log(body ?? "");
//   log(payload ?? "");
// }

// class LocalNotificationService {
//   static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();
//   static const AndroidNotificationChannel channel = AndroidNotificationChannel(
//     'high_importance_channel', // id
//     'Ideal Notifications', // title
//     description: 'For receiving various notifications.', // description
//     importance: Importance.max,
//   );

//   static String? token; // Define token as a static class variable

//   static void initialize(BuildContext context) async {
//     const InitializationSettings initializationSettings = InitializationSettings(
//       android: AndroidInitializationSettings("@mipmap/launcher_icon"),
//       iOS: initializationSettingsDarwin,
//     );

//     _notificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
//     try {
//       _notificationsPlugin.initialize(
//         initializationSettings,
//         onDidReceiveNotificationResponse: onNotificationTap,
//         onDidReceiveBackgroundNotificationResponse: onNotificationTap,
//       );
//     } catch (e) {
//       log("error _notificationsPlugin: $e");
//     }

//     try {
//       token = await FirebaseMessaging.instance.getToken();
//       if (token != null) {
//         log("Get FCM token to server $token");
//       } else {
//         log("FCM token is null.");
//       }
//     } catch (e) {
//       log("Error getting FCM token: $e");
//     }

//     FirebaseMessaging.instance.onTokenRefresh.listen((event) async {
//       token = event;
//       log("Update FCM token to server $token");
//     });
//   }

//   static void display(RemoteMessage message) async {
//     try {
//       final int id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
//       String? payloadEncode;
//       try {
//         payloadEncode = json.encode(message.data);
//       } catch (e) {
//         log("error encode");
//       }

//       final NotificationDetails notificationDetails = NotificationDetails(
//           android: AndroidNotificationDetails(
//         channel.id,
//         channel.name,
//         channelDescription: channel.description,
//         importance: channel.importance,
//         priority: Priority.high,
//         enableVibration: true,
//       ));

//       await _notificationsPlugin.show(
//         id,
//         message.notification?.title ?? '',
//         message.notification?.body ?? '',
//         notificationDetails,
//         payload: payloadEncode,
//       );
//     } on Exception catch (e) {
//       log("display error : $e");
//     }
//   }

//   static void testNotif() async {
//     final NotificationDetails notificationDetails = NotificationDetails(
//         android: AndroidNotificationDetails(
//       channel.id,
//       channel.name,
//       channelDescription: channel.description,
//       importance: channel.importance,
//       priority: Priority.high,
//       enableVibration: true,
//     ));
//     await _notificationsPlugin.show(
//       1000,
//       'Hello beauty',
//       "Welcome to Glamori!",
//       notificationDetails,
//     );
//   }

//   static void onNotificationTapBG(RemoteMessage notificationResponse) async {
//     log('onNotificationTap (${notificationResponse.messageId.toString()}) action tapped: '
//         'payload: ${notificationResponse.data.toString()}');
//     // Map<String, dynamic> payload = notificationResponse.data;
//     // ActionTypeRouteHandler.instance.actionTypeRoutePage(payload);
//   }

//   static void onNotificationTap(NotificationResponse notificationResponse) async {
//     log('onNotificationTap (${notificationResponse.id.toString()}) action tapped: '
//         'payload: ${notificationResponse.payload.toString()}');
//     var payload = json.decode(notificationResponse.payload ?? '');
//     if (payload == null) {
//       return;
//     }
//     // ActionTypeRouteHandler.instance.actionTypeRoutePage(payload);
//   }
// }
