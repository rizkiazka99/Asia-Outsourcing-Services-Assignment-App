import 'package:asiaoutsourcingservices_assignmentapp/core/colors.dart';
import 'package:asiaoutsourcingservices_assignmentapp/core/font_sizes.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/controller/controllers/product_detail_controller.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/view/widgets/back_button.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/view/widgets/default_button.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/view/widgets/product_rating.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/view/widgets/skeleton_loader.dart';
import 'package:asiaoutsourcingservices_assignmentapp/router/screens.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:icony/icony_ikonate.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  PreferredSizeWidget appBar(ProductDetailController controller) {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      leading: backButton(),
      title: Obx(() => controller.isLoading ? const SizedBox.shrink()
          : Text(controller.productDetail!.productName)),
      actions: [
        Obx(() => IconButton(
          onPressed: () {
            controller.isFavorite = !controller.isFavorite;
          }, 
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  spreadRadius: 2,
                  color: contextGrey.withOpacity(0.2),
                  offset: const Offset(0, 3)
                )
              ]
            ),
            child: Icon(
              !controller.isFavorite ? Icons.favorite_border_rounded
                  : Icons.favorite_rounded,
              color: !controller.isFavorite ? Colors.black
                  : primaryColor,
            ),
          )
        ))
      ],
    );
  }

  Widget bottomAppBar(ProductDetailController controller) {
    return BottomAppBar(
      color: Colors.white,
      shadowColor: Colors.white,
      surfaceTintColor: Colors.white,
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Get.toNamed(Routes.CART);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: selectedGrey,
                borderRadius: BorderRadius.circular(10)
              ),
              child: const Icon(
                Icons.shopping_bag_outlined,
                size: 35,
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Obx(() => DefaultButton(
              onTap: () {}, 
              buttonText: 'Add to Cart',
              buttonColor: controller.isLoading ? disabledButton
                  : primaryColor,
            )),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ProductDetailController controller = Get.find<ProductDetailController>();

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: appBar(controller),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Obx(() => !controller.isLoading ? CachedNetworkImage(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                fit: BoxFit.cover,
                imageUrl: controller.productDetail!.productPhoto,
                fadeInDuration: const Duration(milliseconds: 300),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                placeholder: (context, url) => const SpinKitFoldingCube(
                  color: primaryColor,
                  size: 45,
                ),
              ) : SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                child: const SpinKitFoldingCube(
                  color: primaryColor,
                  size: 45,
                ),
              )),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        !controller.isLoading ? Flexible(
                          child: Container(
                            margin: const EdgeInsets.only(right: 35),
                            child: Text(
                              controller.productDetail!.productName,
                              style: h4(fontWeight: FontWeight.w600),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ) : CustomizableSkeletonLoader(
                          height: 25,
                          width: MediaQuery.of(context).size.width / 2,
                        ),
                        !controller.isLoading ? productRating(context)
                            : CustomizableSkeletonLoader(
                              height: 25, 
                              width: MediaQuery.of(context).size.width / 6
                            )
                      ],
                    )),
                    Obx(() => !controller.isLoading ? Text(
                      '\$ ${double.parse(controller.productDetail!.productValue)}',
                      style: h4(fontWeight: FontWeight.w500),
                    ) : Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: CustomizableSkeletonLoader(
                        height: 25,
                        width: MediaQuery.of(context).size.width / 3,
                      ),
                    )),
                    const SizedBox(height: 35),
                    Obx(() => !controller.isLoading ? Text(
                      '- ${controller.productDetail!.productDescription}',
                      style: bodyMd(color: Colors.black),
                      textAlign: TextAlign.justify,
                    ) : CustomizableSkeletonLoader(
                      height: MediaQuery.of(context).size.height / 8,
                      width: MediaQuery.of(context).size.width,
                    )),
                    const SizedBox(height: 35),
                    Obx(() => !controller.isLoading ? Text(
                      'Size',
                      style: h4_5(fontWeight: FontWeight.w500),
                    ) : CustomizableSkeletonLoader(
                      height: 15, 
                      width: MediaQuery.of(context).size.width / 6 
                    )),
                    const SizedBox(height: 8),
                    Obx(() => !controller.isLoading ? Row(
                      children: List.generate(controller.sizes.length, (index) => Obx(() => InkWell(
                        onTap: () {
                          controller.selectedSize = index;
                        },
                        child: Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width / 8,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: controller.selectedSize != index
                                ? mainGrey : Colors.black,
                            border: Border.all(
                              color: Colors.black,
                              width: 1.5
                            )
                          ),
                          child: Center(
                            child: Text(
                              controller.sizes[index],
                              style: h5(
                                color: controller.selectedSize != index
                                    ? Colors.black : Colors.white,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                        ),
                      ))),
                    ) : CustomizableSkeletonLoader(
                      height: 45, 
                      width: MediaQuery.of(context).size.width / 2
                    ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: bottomAppBar(controller)
    );
  }
}