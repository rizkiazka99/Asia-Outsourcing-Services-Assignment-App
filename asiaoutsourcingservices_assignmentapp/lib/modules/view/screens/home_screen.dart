import 'package:asiaoutsourcingservices_assignmentapp/core/colors.dart';
import 'package:asiaoutsourcingservices_assignmentapp/core/font_sizes.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/controller/controllers/home_controller.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/view/widgets/product_card.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/view/widgets/skeleton_loader.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget carousel(HomeController controller) {
    return Column(
      children: [
        CarouselSlider(
          carouselController: controller.carouselController,
          items: controller.carouselData.map((e) {
            return Container(
              margin: const EdgeInsets.only(left: 8, right: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(e)
              )
            );
          }).toList(), 
          options: CarouselOptions(
            height: 180,
            enableInfiniteScroll: true,
            autoPlay: true,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(() {
                controller.carouselIndex = index;
              });
            }
          )
        ),
        const SizedBox(height: 8),
        Center(
          child: DotsIndicator(
            dotsCount: controller.carouselData.length,
            position: controller.carouselIndex,
            decorator: const DotsDecorator(
              activeColor: Colors.black,
              color: contextGrey
            ),
          ),
        )
      ],
    );
  }

  Widget sectionTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: h4(fontWeight: FontWeight.w500),
        ),
        InkWell(
          onTap: () {},
          child: Text(
            'View More >',
            style: h5(
              color: primaryColor, 
              fontWeight: FontWeight.w500
            )
          )
        )
      ],
    );
  }

  Widget categories(HomeController controller) {
    return SizedBox(
      height: 60,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: List.generate(controller.categoryIcons.length, (index) {
            return Obx(() => InkWell(
                  splashFactory: NoSplash.splashFactory,
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    controller.selectedCategory = index;
                  },
                  child: Container(
                    width: 50,
                    padding: const EdgeInsets.fromLTRB(12, 18, 12, 18),
                    margin: const EdgeInsets.only(right: 15),
                    decoration: BoxDecoration(
                        color: controller.selectedCategory != index
                            ? mainGrey
                            : selectedGrey,
                        borderRadius: BorderRadius.circular(8)),
                    child: controller.categoryIcons[index],
                  ),
                ));
          }),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  carousel(controller),
                  const SizedBox(height: 15),
                  sectionTitle('Top Categories'),
                  const SizedBox(height: 15),
                  categories(controller),
                  const SizedBox(height: 25),
                  sectionTitle('New Arrivals'),
                  const SizedBox(height: 15),
                  Obx(() => controller.isLoading ? Column(
                    children: List.generate(3, (index) => const SkeletonLoader()),
                  ) : Column(
                    children: List.generate(controller.products!.data.table.length, (index) {
                        return ProductCard(
                          products: controller.products!,
                          index: index,
                        );
                      }
                    ),
                  ))
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}