import 'package:asiaoutsourcingservices_assignmentapp/core/colors.dart';
import 'package:asiaoutsourcingservices_assignmentapp/core/font_sizes.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/model/models/products_response.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/view/widgets/product_rating.dart';
import 'package:asiaoutsourcingservices_assignmentapp/router/screens.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class ProductCard extends StatefulWidget {
  final ProductsResponse? products;
  final int index;

  const ProductCard({
    super.key, 
    required this.products, 
    required this.index
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  Widget productImage() {
    return Flexible(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          imageUrl: widget.products!.data.table[widget.index].productPhoto,
          fadeInDuration: const Duration(milliseconds: 300),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          placeholder: (context, url) => const SpinKitFoldingCube(
            color: primaryColor,
            size: 25,
          ),
        ),
      ),
    );
  }

  Widget addButton() {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: contextGrey.withOpacity(0.2))),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget productInformation() {
    return Flexible(
      flex: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Flexible(
              child: Container(
                margin: const EdgeInsets.only(right: 35),
                child: Text(
                  widget.products!.data.table[widget.index].productName,
                  style: h5(fontWeight: FontWeight.normal),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: const Icon(Icons.favorite_border_rounded),
            )
          ]),
          const SizedBox(height: 4),
          Text(
            'Rp ${double.parse(widget.products!.data.table[widget.index].productValue)}',
            style: h5(),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              productRating(context),
              addButton()
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(
          Routes.PRODUCTDETAIL,
          arguments: {
            'product_id': widget.products!.data.table[widget.index].productId
          }
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 24),
        decoration: BoxDecoration(
          color: mainGrey, 
          borderRadius: BorderRadius.circular(8)
        ),
        child: Row(
          children: [
            productImage(),
            const SizedBox(width: 15),
            productInformation()
          ],
        ),
      ),
    );
  }
}