import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glamori/app/data/services/user_services.dart';
import 'package:glamori/app/modules/rootPage/controllers/root_page_controller.dart';
import 'package:glamori/app/routes/app_pages.dart';
import 'package:glamori/core/assets.dart';
import 'package:glamori/core/themes/colors.dart';
import 'package:glamori/core/themes/style.dart';

class BelanjaWidget extends StatelessWidget {
  const BelanjaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RootPageController>(
        init: RootPageController(),
        builder: (controller) {
          final MediaQueryData mediaQuery = MediaQuery.of(context);
          final double textScaleFactor = mediaQuery.textScaleFactor;
          return Scaffold(
            backgroundColor: AppColors.secondary,
            body: SafeArea(
              child: RefreshIndicator(
                onRefresh: () async {
                  await controller.getAllProduct();
                  controller.getCart();
                },
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const SearchWidget(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            Assets.icMap,
                            width: 13,
                          ).marginOnly(right: 5),
                          Text(
                            controller.location ?? 'LAMPUNG',
                            textAlign: TextAlign.start,
                            style: AppStyle.styleTextBody14(fontWeight: FontWeight.w600),
                          ).marginOnly(),
                        ],
                      ).marginOnly(left: 25).marginOnly(top: 10),
                      // const KategoriProdukBelanja(),
                      const SizedBox(height: 10),
                      controller.allProudct?.data?.isEmpty == true
                          ? Column(
                              children: [
                                const SizedBox(height: 120),
                                SvgPicture.asset(
                                  Assets.icNoProduct,
                                  width: 200,
                                ),
                              ],
                            )
                          : GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10.0,
                                crossAxisSpacing: 8.0,
                                childAspectRatio: mediaQuery.devicePixelRatio < 3 ? 14.5 / 20 : 14.5 / 20,
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              itemCount: controller.allProudct?.data?.length,
                              primary: false,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                String? productName = controller.allProudct?.data?[index].name;
                                int? productPrice = controller.allProudct?.data?[index].price;
                                String? productId = controller.allProudct?.data?[index].sId;
                                String? productImage = controller.allProudct?.data?[index].image;
                                return GestureDetector(
                                  onTap: () {
                                    controller.getTonamedDetailBelanja(productId ?? '', productImage ?? '');
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: AppColors.yellowSoft,
                                    ),
                                    child: Column(
                                      children: [
                                        productImage != null
                                            ? ClipRRect(
                                                borderRadius: const BorderRadius.only(
                                                  topLeft: Radius.circular(16.0),
                                                  topRight: Radius.circular(16.0),
                                                ),
                                                child: Image.network(
                                                  productImage,
                                                  width: 175,
                                                  height: 140,
                                                  fit: BoxFit.cover,
                                                ),
                                              ).marginOnly(bottom: 10)
                                            : const SizedBox.shrink(),
                                        Text(productName ?? "",
                                            textAlign: TextAlign.center,
                                            maxLines: mediaQuery.devicePixelRatio > 3.3 ? 1 : 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: mediaQuery.devicePixelRatio < 2.7
                                                ? AppStyle.styleTextBody15(colorText: AppColors.primary)
                                                : mediaQuery.devicePixelRatio <= 3
                                                    ? AppStyle.styleTextBody15(colorText: AppColors.primary)
                                                    : mediaQuery.devicePixelRatio >= 3.4
                                                        ? AppStyle.styleTextBody7(colorText: AppColors.primary)
                                                        : AppStyle.styleTextBody11(colorText: AppColors.primary)),
                                        Expanded(
                                          child: Text(
                                            controller.formatPrice(productPrice ?? 0),
                                            style: mediaQuery.devicePixelRatio <= 3 ? AppStyle.styleTextBody15(fontWeight: FontWeight.w600) : AppStyle.styleTextBody10(fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ).paddingOnly(right: 10),
                      const SizedBox(height: 120),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class KategoriProdukBelanja extends StatelessWidget {
  const KategoriProdukBelanja({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RootPageController>(builder: (controller) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        height: 120,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.belanjaItems.length,
          itemBuilder: (context, index) {
            var data = controller.belanjaItems[index];
            return GestureDetector(
              onTap: () {
                controller.setSelectedBelanjaItem(data);
              },
              child: SizedBox(
                width: 110,
                child: Card(
                  color: AppColors.white,
                  elevation: 0.4,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: controller.selectedBelanjaItem?.id == data.id ? AppColors.yellowSoft : AppColors.white,
                      border: Border.all(
                        width: 1,
                        color: controller.selectedBelanjaItem?.id == data.id ? AppColors.yellow : Colors.transparent,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          data.title,
                          textAlign: TextAlign.center,
                          style: AppStyle.styleTextBody14(
                            colorText: controller.selectedBelanjaItem?.id == data.id ? AppColors.yellow : AppColors.textBlack,
                            fontWeight: controller.selectedBelanjaItem?.id == data.id ? FontWeight.w600 : FontWeight.w100,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RootPageController>(builder: (controller) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextField(
                  decoration: AppStyle.inputDecorationFloating(
                    "Search",
                    suffixIcon: const Icon(
                      Icons.search,
                      size: 25,
                      color: AppColors.textGrey,
                    ),
                  ),
                  controller: controller.searchController,
                  onChanged: (query) async {
                    if (query.isNotEmpty) {
                      await controller.getSearchProduct(query);
                    } else {
                      await controller.getAllProduct();
                    }
                  },
                ).marginOnly(right: 0),
              ),
              Stack(
                children: [
                  IconButton(
                    onPressed: () {
                      controller.getTonamedKeranjang();
                    },
                    icon: SvgPicture.asset(
                      "assets/icons/cart.svg",
                      width: 35,
                    ),
                  ),
                  Positioned(
                    right: 2,
                    child: Container(
                      height: 17,
                      width: 17,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: AppColors.yellow),
                      child: Text(
                        controller.carts.length.toString(),
                        textAlign: TextAlign.center,
                        style: AppStyle.styleTextBody12(colorText: AppColors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ).marginSymmetric(horizontal: 20),
        ],
      );
    });
  }
}
