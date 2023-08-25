part of 'screens.dart';

abstract class _Paths {
  _Paths._();
  static const DASHBOARD = '/dashboard';
  static const HOME = '/home_screen';
  static const PRODUCTDETAIL = '/product_detail_screen';
  static const CART = '/cart_screen';
}

abstract class Routes {
  Routes._();
  static const DASHBOARD = _Paths.DASHBOARD;
  static const HOME = _Paths.HOME;
  static const PRODUCTDETAIL = _Paths.PRODUCTDETAIL;
  static const CART = _Paths.CART;
}