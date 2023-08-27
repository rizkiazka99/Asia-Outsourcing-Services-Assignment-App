import 'package:asiaoutsourcingservices_assignmentapp/core/colors.dart';
import 'package:asiaoutsourcingservices_assignmentapp/core/font_sizes.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/controller/controllers/cart_controller.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/controller/controllers/internet_controller.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/view/widgets/cart_item_card.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/view/widgets/confirmation_dialog.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/view/widgets/default_button.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/view/widgets/no_internet_indicator.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/view/widgets/skeleton_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Widget emptyCart() {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/empty.png',
            width: 250,
            height: 250,
          ),
          const SizedBox(height: 15),
          Text(
            'You don\'t have anything in your cart, a little bit of shopping wouldn\'t hurt :)',
            style: h5(fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  Widget items(CartController controller) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(right: 4),
      child: Scrollbar(
        controller: controller.scrollController,
        thumbVisibility: true,
        child: SingleChildScrollView(
          controller: controller.scrollController,
          padding: const EdgeInsets.all(16),
          physics: const BouncingScrollPhysics(),
          child: Obx(() => !controller.isLoading
              ? Column(
                  children: List.generate(controller.items.length, (index) =>
                    CartItemCard(
                      items: controller.items,
                      index: index,
                      onTapIncrement: () {
                        controller.updateCartItem(index, true);
                      },
                      onTapDecrement: () {
                        controller.updateCartItem(index, false);
                        if (controller.items[index].quantity == 1) {
                          Get.dialog(
                            ConfirmationDialog(
                              title: 'Hold up!', 
                              content: 'Are you sure you want to discard this item from your cart?', 
                              onConfirmation: () {
                                controller.deleteCartItem(index);
                                Get.back();
                              },
                              onCancellation: () {
                                controller.updateCartItem(index, true);
                                Get.back();
                              },
                            )
                          );
                        }
                      },
                    )
                  ),
                ) : Column(
                children: List.generate(3, (index) => const CartItemSkeletonLoader()),
              )),
        ),
      ),
    );
  }

  Widget billingInformation(CartController controller) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.fromLTRB(16, 32, 16, 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: mainGrey),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Billing Information',
            style: h5(
              color: billingInformationColor, 
              fontWeight: FontWeight.w500
            ),
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order Total',
                style: bodyLg(fontWeight: FontWeight.w500),
              ),
              Obx(() => Text(
                    'Rp ${controller.bulkPrice}',
                    style: h5(),
                  ))
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tax',
                style: bodyLg(fontWeight: FontWeight.w500),
              ),
              Obx(() => Text(
                    'Rp ${controller.tax}',
                    style: h5(),
                  ))
            ],
          ),
          const SizedBox(height: 50),
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              '-------------------',
              style: h5(fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Grand Total',
                style: bodyLg(fontWeight: FontWeight.w500),
              ),
              Obx(() => Text(
                    'Rp ${controller.total}',
                    style: h5(),
                  ))
            ],
          ),
        ],
      ),
    );
  }

  Widget bottomAppBar(CartController controller, InternetController internetController) {
    return BottomAppBar(
      color: Colors.white,
      shadowColor: Colors.white,
      surfaceTintColor: Colors.white,
      child: Obx(() => DefaultButton(
        useIcon: true,
        onTap: () {
          if (internetController.connectedToInternet && controller.items.isNotEmpty) {
            Get.dialog(
              ConfirmationDialog(
                title: 'Before you proceed...', 
                content: 'Are you sure you want to checkout your cart? (Just in case you accidentaly pressed checkout or you\'d like to add more stuffs)', 
                onConfirmation: () {
                  controller.initiateCheckout();
                }, 
                onCancellation: () {
                  Get.back();
                }
              )
            );
          }
        },
        icon: Icons.shopping_cart_outlined,
        buttonText: 'Checkout',
        buttonColor: internetController.connectedToInternet && controller.items.isNotEmpty
            ? primaryColor : disabledButton,
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    CartController controller = Get.find<CartController>();
    InternetController internetController = Get.find<InternetController>();

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Obx(() => !internetController.connectedToInternet
                    ? Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: noInternetIndicator(context)
                    ) : const SizedBox.shrink()
                ),
                Obx(() => controller.items.isNotEmpty ? 
                    items(controller) : emptyCart()
                ),
                billingInformation(controller)
              ],
            ),
          ),
        )
      ),
      bottomNavigationBar: bottomAppBar(controller, internetController),
    );
  }
}