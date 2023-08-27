import 'package:asiaoutsourcingservices_assignmentapp/modules/model/data/api_provider.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/model/models/insert_sales_response.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/model/models/products_response.dart';

class Repository {
  final Endpoints _endpoints = Endpoints();

  Future<ProductsResponse> getProducts(data) async {
    final response = await _endpoints.getProducts(data);
    return ProductsResponse.fromJson(response);
  }

  Future<InsertSalesResponse> insertSales(data) async {
    final response = await _endpoints.insertSales(data);
    return InsertSalesResponse.fromJson(response);
  }
}