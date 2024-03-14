// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'flavors.dart';

import 'main.dart' as runner;
// import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> main() async {
  F.appFlavor = Flavor.app_staging;
  await runner.main();
}
