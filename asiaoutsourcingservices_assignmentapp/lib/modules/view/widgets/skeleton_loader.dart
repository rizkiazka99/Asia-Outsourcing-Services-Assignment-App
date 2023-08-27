import 'package:asiaoutsourcingservices_assignmentapp/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class SkeletonLoader extends StatelessWidget {
  const SkeletonLoader({super.key});

  Widget skeletonBar(double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8), 
        color: skeletonBarColor
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 142,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 24),
      child: Stack(
        children: [
          SkeletonAnimation(
            shimmerColor: Colors.white,
            shimmerDuration: 800,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(color: backgroundColorPrimary)
                ]
              ),
            )
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Flexible(
                  child: skeletonBar(
                    MediaQuery.of(context).size.width / 4,
                    105
                  ),
                ),
                const SizedBox(width: 15),
                Flexible(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          skeletonBar(
                            MediaQuery.of(context).size.width / 2.5,
                            25
                          ),
                          skeletonBar(
                            MediaQuery.of(context).size.width / 10,
                            25
                          )
                        ],
                      ),
                      const SizedBox(height: 4),
                      skeletonBar(
                        MediaQuery.of(context).size.width / 4,
                        25
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          skeletonBar(
                            MediaQuery.of(context).size.width / 6,
                            30
                          ),
                          skeletonBar(
                            MediaQuery.of(context).size.width / 10,
                            30
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CustomizableSkeletonLoader extends StatelessWidget {
  final double height;
  final double width;

  const CustomizableSkeletonLoader({
    super.key, 
    required this.height, 
    required this.width
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: SkeletonAnimation(
        shimmerColor: Colors.white,
        shimmerDuration: 800,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(color: backgroundColorPrimary)
            ]
          ),
        )
      ),
    );
  }
}

class CartItemSkeletonLoader extends StatelessWidget {
  const CartItemSkeletonLoader({super.key});

  Widget skeletonBar(double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8), 
        color: skeletonBarColor
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 142,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 24),
      child: Stack(
        children: [
          SkeletonAnimation(
            shimmerColor: Colors.white,
            shimmerDuration: 800,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(color: backgroundColorPrimary)
                ]
              ),
            )
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Flexible(
                  child: skeletonBar(
                    MediaQuery.of(context).size.width / 4,
                    105
                  ),
                ),
                const SizedBox(width: 15),
                Flexible(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      skeletonBar(
                        MediaQuery.of(context).size.width / 2.5,
                        25
                      ),
                      const SizedBox(height: 4),
                      skeletonBar(
                        MediaQuery.of(context).size.width / 4,
                        25
                      ),
                      const SizedBox(height: 4),
                      skeletonBar(
                        MediaQuery.of(context).size.width / 6,
                        30
                      )
                    ],
                  ),
                ),
                Flexible(
                  child: skeletonBar(
                    MediaQuery.of(context).size.width / 10, 
                    140
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}