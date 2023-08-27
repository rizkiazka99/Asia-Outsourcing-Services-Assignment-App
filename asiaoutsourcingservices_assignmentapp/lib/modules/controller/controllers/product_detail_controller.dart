import 'package:asiaoutsourcingservices_assignmentapp/core/colors.dart';
import 'package:asiaoutsourcingservices_assignmentapp/helpers/constants.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/model/data/repository.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/model/data/sqlite_provider.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/model/models/cart_response.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/model/models/products_response.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/model/models/table_response.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/view/widgets/custom_snackbar.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/view/widgets/loader_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class ProductDetailController extends GetxController {
  final Repository _repository = Repository();
  late String productId;

  RxBool _isLoading = false.obs;
  Rxn<Table> _productDetail = Rxn<Table>();
  RxBool _isFavorite = false.obs;
  RxString _selectedSize = 'L'.obs;

  bool get isLoading => _isLoading.value;
  Table? get productDetail => _productDetail.value;
  bool get isFavorite => _isFavorite.value;
  String get selectedSize => _selectedSize.value;
  
  set isLoading(bool isLoading) =>
      this._isLoading.value = isLoading;
  set productDetail(Table? productDetail) =>
      this._productDetail.value = productDetail;
  set isFavorite(bool isFavorite) =>
      this._isFavorite.value = isFavorite;
  set selectedSize(String selectedSize) =>
      this._selectedSize.value = selectedSize;

  List sizes = ['S', 'M', 'L', 'XL'];

  @override
  void onInit() {
    super.onInit();
    productId = Get.arguments['product_id'];
    getProductDetail();
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
        productValue: productDetail!.productValue, 
        productSize: selectedSize, 
        quantity: 1, 
        createdAt: DateTime.now().toIso8601String()
      )).then((value) {
        Get.back();
        defaultSnackbar('Yay!', 'Item has been added to your cart');
      });
    } catch(err) {
      print(err);
      Get.back();
      defaultSnackbar('Oops!', 'Something went wrong, please try again');
    }
  }
}