import 'package:asiaoutsourcingservices_assignmentapp/helpers/constants.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/model/data/repository.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/model/models/products_response.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:icony/icony_ikonate.dart';

class HomeController extends GetxController {
  final Repository _repository = Repository();
  CarouselController carouselController = CarouselController();

  RxInt _carouselIndex = 0.obs;
  RxInt _selectedCategory = 0.obs;
  RxBool _isLoading = false.obs;
  Rxn<ProductsResponse> _products = Rxn<ProductsResponse>();

  int get carouselIndex => _carouselIndex.value;
  int get selectedCategory => _selectedCategory.value;
  bool get isLoading => _isLoading.value;
  ProductsResponse? get products => _products.value;

  set carouselIndex(int carouselIndex) =>
      this._carouselIndex.value = carouselIndex;
  set selectedCategory(int selectedCategory) =>
      this._selectedCategory.value = selectedCategory;
  set isLoading(bool isLoading) =>
      this._isLoading.value = isLoading;
  set products(ProductsResponse? products) =>
      this._products.value = products;

  List carouselData = [
    'assets/images/carousel_image.jpg',
    'assets/images/carousel_image.jpg',
    'assets/images/carousel_image.jpg',
    'assets/images/carousel_image.jpg',
    'assets/images/carousel_image.jpg'
  ];

  List categoryIcons = [
    const FaIcon(
      FontAwesomeIcons.shirt,
      color: Colors.black,
    ),
    const Center(
      child: FaIcon(
        FontAwesomeIcons.personDress,
        color: Colors.black,
      ),
    ),
    const Center(
      child: Ikonate(
        Ikonate.headphones,
        color: Colors.black,
      ),
    ),
    const Center(
      child: Ikonate(
        Ikonate.watch,
        color: Colors.black,
      ),
    ),
    const Center(
      child: Ikonate(
        Ikonate.smartphone,
        color: Colors.black,
      ),
    ),
    const Center(
      child: Ikonate(
        Ikonate.laptop,
        color: Colors.black,
      ),
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    getProducts();
  }

  @override
  void onClose() {
    print('homeController disposed');
    super.onClose();
  }

  Future<ProductsResponse?> getProducts() async {
    isLoading = true;
    ProductsResponse? res = await _repository.getProducts(Constants.data);
    products = res;
    isLoading = false;

    return products;
  }
}