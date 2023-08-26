import 'package:asiaoutsourcingservices_assignmentapp/helpers/constants.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/model/data/repository.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/model/models/products_response.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/model/models/table_response.dart';
import 'package:get/get.dart';

class ProductDetailController extends GetxController {
  final Repository _repository = Repository();
  late String productId;

  RxBool _isLoading = false.obs;
  Rxn<Table> _productDetail = Rxn<Table>();
  RxBool _isFavorite = false.obs;
  RxInt _selectedSize = 1.obs;

  bool get isLoading => _isLoading.value;
  Table? get productDetail => _productDetail.value;
  bool get isFavorite => _isFavorite.value;
  int get selectedSize => _selectedSize.value;
  
  set isLoading(bool isLoading) =>
      this._isLoading.value = isLoading;
  set productDetail(Table? productDetail) =>
      this._productDetail.value = productDetail;
  set isFavorite(bool isFavorite) =>
      this._isFavorite.value = isFavorite;
  set selectedSize(int selectedSize) =>
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
}