

part of 'app_pages.dart';

abstract class Routes{
  Routes._();
  static const BASE =_Paths.BASE;
  static const LOGIN =_Paths.LOGIN;
  static const SPLASH =_Paths.SPLASH;
  static const PRODUCTVIEW =_Paths.PRODUCTVIEW;
  static const SEARCH =_Paths.SEARCH;
  static const PROFILE =_Paths.PROFILE;
  static const WHISHLIST =_Paths.WHISHLIST;
  static const CART =_Paths.CART;
  static const ORDER =_Paths.ORDER;
  static const TIMELINE =_Paths.TIMELINE;

}
abstract class _Paths {
  _Paths._();
  static const BASE ='/base';
  static const LOGIN ='/auth_screen';
  static const SPLASH ='/splash_screen';
  static const PRODUCTVIEW ='/product_screen';
  static const SEARCH ='/Search_screen';
  static const PROFILE ='/profile_screen';
  static const WHISHLIST ='/wishlist_screen';
  static const CART ='/Cart_screen';
  static const ORDER ='/myorder_screen';
  static const TIMELINE ='/timeline_screen';

}
