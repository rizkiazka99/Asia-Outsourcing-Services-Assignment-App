import 'package:asiaoutsourcingservices_assignmentapp/core/colors.dart';
import 'package:asiaoutsourcingservices_assignmentapp/helpers/constants.dart';
import 'package:asiaoutsourcingservices_assignmentapp/helpers/global_functions.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/model/data/repository.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/model/data/sqlite_provider.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/model/models/cart_response.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/model/models/products_response.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/model/models/table_response.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/view/widgets/custom_snackbar.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/view/widgets/loader_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class ProductDetailController extends GetxController {
  final Repository _repository = Repository();
  final GlobalFunctions _globalFunctions = GlobalFunctions();
  late String productId;

  RxBool _isLoading = false.obs;
  Rxn<Table> _productDetail = Rxn<Table>();
  RxBool _isFavorite = false.obs;
  RxString _selectedSize = 'L'.obs;
  RxBool _isCartLoading = false.obs;
  RxList<Cart> _items = <Cart>[].obs;

  bool get isLoading => _isLoading.value;
  Table? get productDetail => _productDetail.value;
  bool get isFavorite => _isFavorite.value;
  String get selectedSize => _selectedSize.value;
  bool get isCartLoading => _isCartLoading.value;
  List<Cart> get items => _items;
  
  set isLoading(bool isLoading) =>
      this._isLoading.value = isLoading;
  set productDetail(Table? productDetail) =>
      this._productDetail.value = productDetail;
  set isFavorite(bool isFavorite) =>
      this._isFavorite.value = isFavorite;
  set selectedSize(String selectedSize) =>
      this._selectedSize.value = selectedSize;
  set isCartLoading(bool isCartLoading) =>
      this._isCartLoading.value = isCartLoading;
  set items(List<Cart> items) =>
      this._items.value = items;

  List sizes = ['S', 'M', 'L', 'XL'];

  @override
  void onInit() {
    super.onInit();
    productId = Get.arguments['product_id'];
    getProductDetail();
    getCartItems();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<Table?> getProductDetail() async {
    isLoading = true;
    ProductsResponse res = await _repository.getProducts(Constants.data);
    int index = res.data.table.indexWhere((element) => 
      element.productId == productId
    );
    productDetail = res.data.table[index];
    isLoading = false;

    return productDetail;
  }

  Future<List<Cart>> getCartItems() async {
    items = await _globalFunctions.getCartItems(isCartLoading, items);
    return items;
  }

  addToCart() async {
    try {
      loaderDialog(
        const SpinKitFoldingCube(
          color: primaryColor,
        ), 
        'Please wait...'
      );
      await SQLHelper.addItem(Cart(
        productId: productDetail!.productId, 
        productName: productDetail!.productName,
        productPhoto: productDetail!.productPhoto,
        productValue: productDetail!.productValue, 
        productSize: selectedSize, 
        quantity: 1, 
        createdAt: DateTime.now().toIso8601String()
      )).then((value) {
        getCartItems();;
        Get.back();
        defaultSnackbar('Yay!', 'Item has been added to your cart');
      });
    } catch(err) {
      print(err);
      Get.back();
      defaultSnackbar('Oops!', 'Something went wrong, please try again');
    }
  }

  updateCartItem(int index) async {
    try {
      loaderDialog(
        const SpinKitFoldingCube(
          color: primaryColor,
        ), 
        'Please wait...'
      );
      await SQLHelper.updateItem(
        items[index].id,
        Cart(
          id: items[index].id,
          productId: productDetail!.productId, 
          productName: productDetail!.productName,
          productPhoto: productDetail!.productPhoto,
          productValue: productDetail!.productValue, 
          productSize: items[index].productSize, 
          quantity: items[index].quantity + 1, 
          createdAt: items[index].createdAt
      )).then((value) {
        getCartItems();
        Get.back();
        defaultSnackbar('Yay!', 'Item quantity has been increased');
      });
    } catch(err) {
      print(err);
      Get.back();
      defaultSnackbar('Oops!', 'Something went wrong, please try again');
    }
  }
}