import 'package:asiaoutsourcingservices_assignmentapp/helpers/global_functions.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/model/models/cart_response.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final GlobalFunctions _globalFunctions = GlobalFunctions();

  RxBool _isLoading = false.obs;
  RxList<Cart> _items = <Cart>[].obs;

  bool get isLoading => _isLoading.value;
  List<Cart> get items => _items;

  set isLoading(bool isLoading) =>
      this._isLoading.value = isLoading;
  set items(List<Cart> items) =>
      this._items.value = items;

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
    return items;
  }
}