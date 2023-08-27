import 'package:asiaoutsourcingservices_assignmentapp/core/colors.dart';
import 'package:asiaoutsourcingservices_assignmentapp/core/font_sizes.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/model/models/cart_response.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CartItemCard extends StatefulWidget {
  final List<Cart> items;
  final int index;
  final dynamic onTapIncrement;
  final dynamic onTapDecrement;

  const CartItemCard({
    super.key,
    required this.items,
    required this.index, 
    required this.onTapIncrement, 
    required this.onTapDecrement
  });

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  Widget productImage() {
    return Flexible(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          imageUrl: widget.items[widget.index].productPhoto,
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

  Widget incrementDecrementButton({ isIncrement, onTapIncrement, onTapDecrement }) {
    return InkWell(
      onTap: isIncrement ? onTapIncrement
          : onTapDecrement,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: isIncrement ? Colors.black
              : selectedGrey,
        ),
        child: Icon(
          isIncrement ? Icons.add : Icons.remove,
          color: isIncrement ? Colors.white
              : Colors.black,
        ),
      ),
    );
  }

  Widget quantity({ onTapIncrement, onTapDecrement }) {
    return Column(
      children: [
        incrementDecrementButton(
          onTapIncrement: onTapIncrement, 
          isIncrement: true
        ),
        const SizedBox(height: 8),
        Text(
          widget.items[widget.index].quantity.toString(),
          style: h5(),
        ),
        const SizedBox(height: 8),
        incrementDecrementButton(
          onTapDecrement: onTapDecrement,
          isIncrement: false
        )
      ],
    );
  }

  Widget productInformation({ onTapIncrement, onTapDecrement }) {
    return Flexible(
      flex: 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 35),
                child: Text(
                  widget.items[widget.index].productName,
                  style: h4(fontWeight: FontWeight.normal),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Rp ${double.parse(widget.items[widget.index].productValue)}',
                style: h4(),
              ),
              const SizedBox(height: 8),
              Text(
                'Size: ${widget.items[widget.index].productSize}',
                style: h5(fontWeight: FontWeight.w500),
              )
            ],
          ),
          quantity(
            onTapIncrement: onTapIncrement,
            onTapDecrement: onTapDecrement
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          productInformation(
            onTapIncrement: widget.onTapIncrement,
            onTapDecrement: widget.onTapDecrement
          ),
        ],
      ),
    );
  }
}