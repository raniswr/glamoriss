import 'package:carousel_slider/carousel_slider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glamori/app/data/services/user_services.dart';
import 'package:glamori/app/modules/rootPage/controllers/root_page_controller.dart';
import 'package:glamori/app/routes/app_pages.dart';
import 'package:glamori/core/assets.dart';
import 'package:glamori/core/themes/colors.dart';
import 'package:glamori/core/themes/style.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: GetBuilder<RootPageController>(
        builder: (controller) {
          return RefreshIndicator(
            onRefresh: () async {
              await controller.getBestsellerProduct();
              await controller.getBestsellerTreatment();
              await controller.getAllArticle();
              await controller.getPromotion();
              await controller.getProfile(UserService.find.user?.id ?? '');
            },
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ExtendedImage.asset(
                        Assets.logo,
                        width: 144,
                        fit: BoxFit.fill,
                      ),
                      GestureDetector(
                        onTap: () async {
                          var dataLogin = await UserService.find.getLocalUser();
                          if (dataLogin == null) {
                            Get.toNamed(Routes.LOGIN_PAGE);
                          } else {
                            Get.toNamed(Routes.NOTIFIKASI_PAGE);
                          }
                        },
                        child: SvgPicture.asset(
                          Assets.icBell,
                          width: 18,
                        ),
                      ),
                    ],
                  ).marginOnly(top: 30).marginSymmetric(horizontal: 10),
                  // const HomeHeader(),
                  // Row(
                  //   children: [
                  //     Text(
                  //       'Ambil di:',
                  //       style: AppStyle.styleTextBody14(),
                  //       textAlign: TextAlign.start,
                  //     ).marginOnly(bottom: 3, left: 20, right: 8),
                  //     GestureDetector(
                  //       onTap: () {
                  //         controller.toLokasi();
                  //       },
                  //       child: Container(
                  //           height: 29,
                  //           width: 120,
                  //           decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(10),
                  //             border: Border.all(color: AppColors.primary, width: 1),
                  //             color: AppColors.secondary,
                  //           ),
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               SvgPicture.asset(
                  //                 Assets.icMap,
                  //                 width: 13,
                  //               ).marginOnly(right: 5),
                  //               Text(
                  //                 controller.location ?? 'LAMPUNG',
                  //                 textAlign: TextAlign.center,
                  //                 style: AppStyle.styleTextBody14(fontWeight: FontWeight.w600),
                  //               ),
                  //             ],
                  //           )),
                  //     ),
                  //   ],
                  // ),

                  const HomeMemberPoint().marginSymmetric(horizontal: 10, vertical: 20),

                  Text(
                    'Penawaran Menarik!',
                    style: AppStyle.styleTextBody16(fontWeight: FontWeight.w600),
                    textAlign: TextAlign.start,
                    maxLines: 1,
                  ).marginOnly(left: 20, bottom: 10),
                  const HomeBanner(),
                  // const HomeCategory(),
                  const HomeBestSeller().marginOnly(top: 40),
                  const ProdukTerlarisHome().marginSymmetric(vertical: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Baca Artikel',
                        style: AppStyle.styleTextBody16(fontWeight: FontWeight.bold),
                      ).marginOnly(left: 30),
                      SizedBox(
                        width: double.infinity,
                        height: 300,
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: controller.allArticle?.data?.docs?.length,
                          physics: const BouncingScrollPhysics(),
                          // primary: false,
                          // shrinkWrap: true,
                          itemBuilder: (context, index) {
                            String images = controller.allArticle?.data?.docs?[index].image ?? '';
                            String title = controller.allArticle?.data?.docs?[index].title ?? '';
                            String description = controller.allArticle?.data?.docs?[index].description ?? '';
                            String video = controller.allArticle?.data?.docs?[index].videoUrl ?? '';
                            String date = controller.allArticle?.data?.docs?[index].date ?? '';
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.articlePage, arguments: {
                                  'title': title,
                                  'description': description,
                                  'image': images,
                                  'date': date,
                                  'videoUrl': video,
                                });
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(builder: (context) => VideoApp()),
                                // );
                              },
                              child: SizedBox(
                                width: double.infinity,
                                height: 103,
                                child: Card(
                                  color: AppColors.white,
                                  elevation: 0.4,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: AppColors.white,
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          images != ''
                                              ? ClipRRect(
                                                  borderRadius: const BorderRadius.only(
                                                    topLeft: Radius.circular(16.0),
                                                    topRight: Radius.circular(16.0),
                                                    bottomLeft: Radius.circular(16.0),
                                                    bottomRight: Radius.circular(16.0),
                                                  ),
                                                  child: Image.network(
                                                    images,
                                                    width: 62,
                                                    height: 62,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ).marginAll(10)
                                              : const SizedBox.shrink(),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  controller.allArticle?.data?.docs?[index].title ?? '',
                                                  style: AppStyle.styleTextBody13(fontWeight: FontWeight.bold),
                                                ),
                                                Text(
                                                  controller.allArticle?.data?.docs?[index].description ?? '',
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: AppStyle.styleTextBody11(),
                                                  textAlign: TextAlign.start,
                                                ).marginOnly(top: 7),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ).marginSymmetric(horizontal: 20),
                      ),
                      Text(
                        'Tonton Video',
                        style: AppStyle.styleTextBody16(fontWeight: FontWeight.bold),
                      ).marginOnly(left: 30, top: 20),
                      Container(
                        width: double.infinity,
                        child: ListView.builder(
                          itemCount: controller.allVideo?.data?.length ?? 0,
                          primary: false,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context, int index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: YoutubePlayer(
                                controller: controller.initializeYoutubePlayerController(controller.allVideo?.data?[index].videoUrl ?? ''),
                                liveUIColor: Colors.amber,
                                showVideoProgressIndicator: false,
                                progressIndicatorColor: Colors.amber,
                                // bottomActions: [
                                //   CurrentPosition(),
                                //   ProgressBar(isExpanded: true),
                                //   FullScreenButton(),
                                //   Dialog.fullscreen(),
                                // ],
                                // onReady: () {
                                //   print('onReady for $index');
                                // },
                                // onEnded: (YoutubeMetaData _md) {
                                //   controller.controller.seekTo(const Duration(seconds: 0));
                                // },
                              ),
                            ).marginSymmetric(horizontal: 20, vertical: 10);
                          },
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ProdukTerlarisHome extends StatelessWidget {
  const ProdukTerlarisHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RootPageController>(builder: (controller) {
      return Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Produk Terlaris',
                  style: AppStyle.styleTextBody16(fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.rootPage);
                    var getPage = Get.find<RootPageController>();
                    getPage.onItemTapped(2);
                  },
                  child: Row(
                    children: [
                      Text(
                        'Lihat Semua Produk ',
                        style: AppStyle.styleTextBody12(fontWeight: FontWeight.w600, colorText: AppColors.yellow),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: AppColors.yellow,
                        size: 8,
                      )
                    ],
                  ),
                ),
              ],
            ).marginSymmetric(horizontal: 25),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
            // color: AppColors.blueSoft,
            height: 230,
            child: controller.bestsellerProudct?.data?.isNotEmpty == true
                ? controller.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.bestsellerProudct?.data?.first.product?.length ?? 0,
                        itemBuilder: (context, index) {
                          var data = controller.bestsellerProudct?.data?.first.product?[index];
                          String? productId = data?.sId;
                          String? productImage = data?.image;

                          return SizedBox(
                            width: 145,
                            child: GestureDetector(
                              onTap: () {
                                controller.getTonamedDetailBelanja(productId ?? '', productImage ?? '');
                              },
                              child: Container(
                                // color: AppColors.yellowSoft,
                                child: Card(
                                  color: AppColors.yellowSoft,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20), // Adjust the radius as needed
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          productImage != null
                                              ? ClipRRect(
                                                  borderRadius: const BorderRadius.only(
                                                    topLeft: Radius.circular(20.0),
                                                    topRight: Radius.circular(20.0),
                                                    // bottomLeft: Radius.circular(16.0),
                                                    // bottomRight: Radius.circular(16.0),
                                                  ),
                                                  child: Image.network(
                                                    productImage,
                                                    width: 175,
                                                    height: 140,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ).marginOnly(bottom: 10)
                                              : const SizedBox.shrink(),
                                          Text(
                                            data?.name ?? '',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppStyle.styleTextBody14(fontWeight: FontWeight.bold, colorText: AppColors.primary),
                                          ).marginSymmetric(horizontal: 8),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                controller.formatPrice(data?.price ?? 0),
                                                style: AppStyle.styleTextBody14(fontWeight: FontWeight.bold),
                                              ),
                                              // Text(
                                              //   '32 terjual',
                                              //   style: AppStyle.styleTextBody11(),
                                              // ).marginOnly(left: 5),
                                            ],
                                          ).marginSymmetric(horizontal: 10),
                                        ],
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: ExtendedImage.asset(
                                          Assets.bestSeller,
                                          width: 60,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })
                : const SizedBox.shrink(),
          ),
        ],
      );
    });
  }
}

class HomeBestSeller extends StatelessWidget {
  const HomeBestSeller({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RootPageController>(builder: (controller) {
      return SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Treatment Terlaris',
                  style: AppStyle.styleTextBody16(fontWeight: FontWeight.bold),
                  maxLines: 1,
                ),
              ],
            ).marginSymmetric(horizontal: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
              height: 230,
              child: controller.bestsellerTreatment?.data?.isNotEmpty == true
                  ? controller.isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.bestsellerTreatment?.data?.first.treatment?.length ?? 0,
                          itemBuilder: (context, index) {
                            var data = controller.bestsellerTreatment?.data?.first.treatment?[index];
                            String? productImage = data?.image;
                            return SizedBox(
                              width: 145,
                              child: Card(
                                color: AppColors.yellowSoft,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20), // Adjust the radius as needed
                                ),
                                elevation: 0,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        productImage != null
                                            ? ClipRRect(
                                                borderRadius: const BorderRadius.only(
                                                  topLeft: Radius.circular(20.0),
                                                  topRight: Radius.circular(20.0),
                                                  // bottomLeft: Radius.circular(16.0),
                                                  // bottomRight: Radius.circular(16.0),
                                                ),
                                                child: Image.network(
                                                  productImage,
                                                  width: 175,
                                                  height: 140,
                                                  fit: BoxFit.cover,
                                                ),
                                              ).marginOnly(bottom: 10)
                                            : const SizedBox.shrink(),
                                        Text(
                                          data?.name ?? '',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: AppStyle.styleTextBody14(fontWeight: FontWeight.bold, colorText: AppColors.primary),
                                        ).marginSymmetric(horizontal: 8),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              controller.formatPrice(data?.price ?? 0),
                                              style: AppStyle.styleTextBody14(fontWeight: FontWeight.bold),
                                            ),
                                            // Text(
                                            //   '32 terjual',
                                            //   style: AppStyle.styleTextBody11(),
                                            // ).marginOnly(left: 5),
                                          ],
                                        ).marginSymmetric(horizontal: 10),
                                      ],
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: ExtendedImage.asset(
                                        Assets.bestSeller,
                                        width: 60,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          })
                  : SizedBox.shrink(),
            ),
          ],
        ),
      );
    });
  }
}

class HomeCategory extends StatelessWidget {
  const HomeCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Kategori Produk',
              style: AppStyle.styleTextBody16(fontWeight: FontWeight.bold),
            ).marginOnly(left: 20).marginOnly(top: 20),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          height: 150,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 7,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 115,
                  child: Card(
                    color: AppColors.white,
                    elevation: 0.4,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.white,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              Assets.icPerawatanWajah,
                              width: 40,
                            ).marginOnly(top: 5),
                            Text(
                              'Perawatan wajah',
                              textAlign: TextAlign.center,
                              style: AppStyle.styleTextBody14(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}

class HomeBanner extends StatelessWidget {
  const HomeBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RootPageController>(
      init: RootPageController(),
      builder: (controller) {
        return Stack(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 180.0,
                viewportFraction: 1.0,
                onPageChanged: controller.onPageChanged,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 2),
              ),
              items: controller.imageUrls.map((url) {
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.promotionPage, arguments: {
                      'promotion': controller.promotion?.data?.docs?[controller.currentIndex],
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(url),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ).marginSymmetric(horizontal: 5),
                );
              }).toList(),
            ),
            Positioned(
              bottom: 10.0,
              left: 0.0,
              right: 0.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: controller.imageUrls.map((url) {
                  int index = controller.imageUrls.indexOf(url);
                  return Container(
                    width: 8.0,
                    height: 3.0,
                    margin: const EdgeInsets.symmetric(horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: controller.currentIndex == index ? AppColors.textBlack : AppColors.white,
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}

class HomeMemberPoint extends StatelessWidget {
  const HomeMemberPoint({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RootPageController>(builder: (controller) {
      return Row(
        children: [
          Container(
            width: 185,
            height: 84,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.yellowLights,
              // boxShadow: const [
              //   BoxShadow(
              //     color: AppColors.grey,
              //     spreadRadius: 1,
              //     blurRadius: 2,
              //     offset: Offset(0, 2),
              //   ),
              // ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.redeemPage);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Membership Points',
                          style: AppStyle.styleTextBody14(),
                          maxLines: 1,
                          textAlign: TextAlign.center,
                        ).marginOnly(top: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              // '${controller.users?.data?.point ?? 0}',
                              '${controller.users?.data?.point ?? 0}',
                              style: AppStyle.styleTextBody30(fontWeight: FontWeight.w600),
                            ),
                            const Icon(
                              Icons.favorite,
                              color: AppColors.primary,
                              size: 30,
                            ),
                            Text(
                              'Detail',
                              style: AppStyle.styleTextBody12(colorText: AppColors.yellow),
                              maxLines: 1,
                            ).marginOnly(left: 20)
                          ],
                        ),
                      ],
                    ),
                  ).marginOnly(left: 10),
                ),
              ],
            ),
          ).marginOnly(right: 10),
          Container(
            width: 185,
            height: 84,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.yellowLights,
              // boxShadow: const [
              //   BoxShadow(
              //     color: AppColors.grey,
              //     spreadRadius: 1,
              //     blurRadius: 2,
              //     offset: Offset(0, 2),
              //   ),
              // ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.MEMBERSHIP_LEVEL);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Membership Level',
                          style: AppStyle.styleTextBody14(),
                          maxLines: 1,
                        ).marginOnly(top: 10, bottom: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              controller.users?.data?.memberLevel == 'gold'
                                  ? 'Gold'
                                  : controller.users?.data?.memberLevel == 'silver'
                                      ? 'Silver'
                                      : 'Bronze',
                              style: AppStyle.styleTextBody25(fontWeight: FontWeight.w600, colorText: AppColors.yellow),
                            ).marginSymmetric(horizontal: 8),
                            Text(
                              'Detail',
                              style: AppStyle.styleTextBody12(colorText: AppColors.yellow),
                              maxLines: 1,
                            ).marginOnly(left: 20)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RootPageController>(builder: (controller) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.isLogin == true ? 'Hello, ${(controller.users?.data?.fullname?.split(" ").elementAt(0) ?? '')},' : 'Hallo, Beauty.',
                style: AppStyle.styleTextBody20(fontWeight: FontWeight.w600),
                textAlign: TextAlign.start,
              ).marginOnly(top: 5, bottom: 3),
              Text(
                'Percantik kulitmu, bersama Glamori!',
                style: AppStyle.styleTextBody14(),
                textAlign: TextAlign.start,
              ).marginOnly(bottom: 5),
            ],
          ),
          GestureDetector(
            onTap: () async {
              var dataLogin = await UserService.find.getLocalUser();
              if (dataLogin == null) {
                Get.toNamed(Routes.LOGIN_PAGE);
              } else {
                Get.toNamed(Routes.NOTIFIKASI_PAGE);
              }
            },
            child: SvgPicture.asset(
              Assets.icBell,
              width: 18,
            ),
          )
        ],
      ).marginSymmetric(horizontal: 20);
    });
  }
}

class CustomBulletTitle extends StatelessWidget {
  const CustomBulletTitle({
    Key? key,
    required this.bulletColor,
    required this.text,
  }) : super(key: key);

  final Color bulletColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 3,
          backgroundColor: bulletColor,
        ).marginOnly(top: 5),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 13, color: AppColors.textBlack), // You can customize the style here
          ),
        ),
      ],
    );
  }
}
