import 'package:asiaoutsourcingservices_assignmentapp/helpers/global_functions.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/model/data/sqlite_provider.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/model/models/cart_response.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/view/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  ScrollController scrollController = ScrollController();
  final GlobalFunctions _globalFunctions = GlobalFunctions();

  RxBool _isLoading = false.obs;
  RxList<Cart> _items = <Cart>[].obs;
  RxInt _bulkPrice = 0.obs;
  RxInt _tax = 0.obs;
  RxInt _total = 0.obs;

  bool get isLoading => _isLoading.value;
  List<Cart> get items => _items;
  int get bulkPrice => _bulkPrice.value;
  int get tax => _tax.value;
  int get total => _total.value;

  set isLoading(bool isLoading) =>
      this._isLoading.value = isLoading;
  set items(List<Cart> items) =>
      this._items.value = items;
  set bulkPrice(int bulkPrice) =>
      this._bulkPrice.value = bulkPrice;
  set tax(int tax) =>
      this._tax.value = tax;
  set total(int total) =>
      this._total.value = total;

  @override
  void onInit() {
    super.onInit();
    getCartItems();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<List<Cart>> getCartItems() async {
    items = await _globalFunctions.getCartItems(isLoading, items);
    totalPrice();
    return items;
  }

  updateCartItem(int index, bool isIncrement) async {
    try {
      await SQLHelper.updateItem(
        items[index].id,
        Cart(
          id: items[index].id,
          productId: items[index].productId, 
          productName: items[index].productName,
          productPhoto: items[index].productPhoto,
          productValue: items[index].productValue, 
          productSize: items[index].productSize, 
          quantity: isIncrement ? items[index].quantity + 1
              : items[index].quantity - 1, 
          createdAt: items[index].createdAt
      )).then((value) {
        bulkPrice = 0;
        tax = 0;
        total = 0;
        getCartItems();
      });
    } catch(err) {
      print(err);
      Get.back();
      defaultSnackbar('Oops!', 'Something went wrong, please try again');
    }
  }

  totalPrice() {
    if (items.isNotEmpty) {
      for(var i = 0; i < items.length; i++) {
        int priceByQuantity = items[i].quantity * int.parse(items[i].productValue);
        bulkPrice += priceByQuantity;
      }

      tax = ((10 / 100) * bulkPrice).round();
      total = tax + bulkPrice;
      return total;
    } else {
      bulkPrice = 0;
      tax = 0;
      total = 0;
      return total;
    }
  }
}