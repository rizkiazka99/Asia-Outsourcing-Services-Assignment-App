import 'package:asiaoutsourcingservices_assignmentapp/modules/controller/bindings/cart_binding.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/controller/bindings/dashboard_binding.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/controller/bindings/home_binding.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/controller/bindings/product_detail_binding.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/view/screens/cart_screen.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/view/screens/dashboard.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/view/screens/home_screen.dart';
import 'package:asiaoutsourcingservices_assignmentapp/modules/view/screens/product_detail_screen.dart';
import 'package:get/get.dart';

part 'routes.dart';

class AppScreens {
  static const INITIAL = Routes.DASHBOARD;
  static final SCREENS = [
    GetPage(
      name: Routes.DASHBOARD, 
      page: () => const Dashboard(),
      bindings: [
        DashboardBinding(),
        HomeBinding(),
      ]
    ),
    GetPage(
      name: Routes.HOME, 
      page: () => const HomeScreen(),
      binding: HomeBinding()
    ),
    GetPage(
      name: Routes.PRODUCTDETAIL, 
      page: () => const ProductDetailScreen(),
      binding: ProductDetailBinding()
    ),
    GetPage(
      name: Routes.CART,
      page: () => const CartScreen(),
      binding: CartBinding()
    )
  ];
}