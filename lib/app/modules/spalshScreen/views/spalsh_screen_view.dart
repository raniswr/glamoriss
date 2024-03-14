import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:glamori/core/assets.dart';

import '../controllers/spalsh_screen_controller.dart';

class SpalshScreenView extends GetView<SpalshScreenController> {
  const SpalshScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ExtendedImage.asset(
        Assets.logo,
        width: 234,
        fit: BoxFit.fill,
      ),
    ));
  }
}
