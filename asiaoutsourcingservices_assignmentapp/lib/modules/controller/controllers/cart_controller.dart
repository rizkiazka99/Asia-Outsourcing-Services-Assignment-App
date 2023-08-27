import 'dart:async';
import 'package:asiaoutsourcingservices_assignmentapp/core/colors.dart';
import 'package:asiaoutsourcingservices_assignmentapp/helpers/global_functions.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/model/data/repository.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/model/data/sqlite_provider.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/model/models/cart_response.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/model/models/insert_sales_response.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/view/widgets/custom_snackbar.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/view/widgets/loader_dialog.dart';
import 'package:asiaoutsourcingservices_assignmentapp/router/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final Repository _repository = Repository();
  final GlobalFunctions _globalFunctions = GlobalFunctions();
  ScrollController scrollController = ScrollController();

  RxBool _isLoading = false.obs;
  RxList<Cart> _items = <Cart>[].obs;
  RxInt _bulkPrice = 0.obs;
  RxInt _tax = 0.obs;
  RxInt _total = 0.obs;
  RxBool _checkoutLoading = false.obs;
  Rxn<InsertSalesResponse> _checkout = Rxn<InsertSalesResponse>();
  
  bool get isLoading => _isLoading.value;
  List<Cart> get items => _items;
  int get bulkPrice => _bulkPrice.value;
  int get tax => _tax.value;
  int get total => _total.value;
  bool get checkoutLoading => _checkoutLoading.value;
  InsertSalesResponse? get checkout => _checkout.value;

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
  set checkoutLoading(bool checkoutLoading) =>
      this._checkoutLoading.value = checkoutLoading;
  set checkout(InsertSalesResponse? checkout) =>
      this._checkout.value = checkout;

  @override
  void onInit() {
    super.onInit();
    getCartItems();
  }

  @override
  void onClose() {
    print('cartController disposed');
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

  deleteCartItem(int index) async {
    try {
      await SQLHelper.deleteItem(
        items[index].id
      ).then((value) {
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

  Future<InsertSalesResponse?> insertSales() async {
    List dataDetail = items.map((e) => e.toMap()).toList();
    dynamic data = {
      "KEY": "YhNnM/2K++gp/FMWA+m0Pg==",
      "pmethod": "insert sales",
      "pdata1": "SO-1112",
      "pdata2": "Puri",
      "pdata3": "Grab Instan",
      "pdata4": "OVO",
      "pdata5": "JK",
      "pdataDetail": dataDetail
    };

    checkoutLoading = true;
    InsertSalesResponse? res = await _repository.insertSales(data);
    checkout = res;
    checkoutLoading = false;

    return checkout;
  }

  initiateCheckout() async {
    try {
      loaderDialog(
        const SpinKitFoldingCube(
          color: primaryColor,
          size: 35,
        ), 
        'Please wait...'
      );
      await insertSales();

      if (checkout!.success) {
        for(var i = 0; i < items.length; i++) {
          deleteCartItem(i);
        }
        Get.back();
        Get.offNamed(Routes.DASHBOARD);
        defaultSnackbar('Yay!', 'Your order has been made');
      } else {
        Get.back();
        defaultSnackbar('Oops!', checkout!.message);
      }
    } catch(err) {
      print(err);
      Get.back();
      defaultSnackbar('Oops!', 'An unknown error occurred');
    }
  }
}