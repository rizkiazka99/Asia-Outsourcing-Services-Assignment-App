import 'package:asiaoutsourcingservices_assignmentapp/modules/model/data/sqlite_provider.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/model/models/cart_response.dart';

class GlobalFunctions {
  Future<List<Cart>> getCartItems(bool isLoading, List<Cart> items) async {
    isLoading = true;
    List<Cart> res = await SQLHelper.getItems();
    items = res;
    isLoading = false;

    return items;
  }
}
