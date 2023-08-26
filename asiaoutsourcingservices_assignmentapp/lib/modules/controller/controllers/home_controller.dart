import 'package:asiaoutsourcingservices_assignmentapp/modules/model/data/repository.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/model/models/products_response.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final Repository _repository = Repository();

  RxBool _isLoading = false.obs;
  Rxn<ProductsResponse> _products = Rxn<ProductsResponse>();

  bool get isLoading => _isLoading.value;
  ProductsResponse? get products => _products.value;

  set isLoading(bool isLoading) =>
      this._isLoading.value = isLoading;
  set products(ProductsResponse? products) =>
      this._products.value = products;

  @override
  void onInit() {
    super.onInit();
    getProducts();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<ProductsResponse?> getProducts() async {
    var data = {
      'KEY': 'YhNnM/2K++gp/FMWA+m0Pg==',
      'pmethod': 'Get Product',
      'pemail': 'JK',
      'pwhere6': '1',
      'pwhere7': '4'
    };

    isLoading = true;
    ProductsResponse? res = await _repository.getProducts(data);
    products = res;
    isLoading = false;

    return products;
  }
}