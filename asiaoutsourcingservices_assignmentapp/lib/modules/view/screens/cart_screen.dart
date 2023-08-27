import 'package:asiaoutsourcingservices_assignmentapp/core/colors.dart';
import 'package:asiaoutsourcingservices_assignmentapp/core/font_sizes.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/controller/controllers/cart_controller.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/view/widgets/cart_item_card.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/view/widgets/skeleton_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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
                  children: List.generate(controller.items.length, (index) {
                    return CartItemCard(
                      items: controller.items,
                      index: index,
                      onTapIncrement: () {
                        controller.updateCartItem(index, true);
                      },
                      onTapDecrement: () {
                        controller.updateCartItem(index, false);
                      },
                    );
                  }),
                )
              : Column(
                  children:
                      List.generate(3, (index) => const CartItemSkeletonLoader()),
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

  @override
  Widget build(BuildContext context) {
    CartController controller = Get.find<CartController>();

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                items(controller),
                billingInformation(controller)
              ],
            ),
          ),
        )
      ),
    );
  }
}