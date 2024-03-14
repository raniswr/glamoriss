import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glamori/app/routes/app_pages.dart';
import 'package:glamori/core/assets.dart';
import 'package:glamori/core/themes/colors.dart';
import 'package:glamori/core/themes/style.dart';
import '../controllers/article_page_controller.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ArticlePageView extends GetView<ArticlePageController> {
  const ArticlePageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.secondary,
        title: Text(
          'Article',
          textAlign: TextAlign.center,
          style: AppStyle.styleTextBody18(fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
            icon: SvgPicture.asset(
              Assets.icBack,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: SingleChildScrollView(
        child: GetBuilder<ArticlePageController>(
          init: ArticlePageController(), // Initialize the controller here
          builder: (controller) {
            return Column(
              children: [
                IntrinsicHeight(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: AppColors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.grey,
                          spreadRadius: 0.3,
                          blurRadius: 0.7,
                          offset: Offset(0, 0.4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          controller.title ?? '',
                          style: AppStyle.styleTextBody16(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          controller.formatDate(controller.date),
                          style: AppStyle.styleTextBody14(),
                          textAlign: TextAlign.justify,
                        ).marginOnly(top: 5),
                        controller.image != null
                            ? ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(16.0),
                                  topRight: Radius.circular(16.0),
                                  bottomLeft: Radius.circular(16.0),
                                  bottomRight: Radius.circular(16.0),
                                ),
                                child: Image.network(
                                  controller.image ?? '',
                                  width: 440,
                                  height: 202,
                                  fit: BoxFit.cover,
                                ),
                              ).marginSymmetric(vertical: 20, horizontal: 5)
                            : const SizedBox.shrink(),
                        SizedBox(
                          width: double.infinity,
                          child: IntrinsicHeight(
                            child: MarkdownBody(
                              data: controller.description ?? '',
                              styleSheet: MarkdownStyleSheet(
                                h1: TextStyle(fontSize: 24),
                                h2: TextStyle(fontSize: 20),
                                a: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ).marginAll(20),
                  ).marginAll(20),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
