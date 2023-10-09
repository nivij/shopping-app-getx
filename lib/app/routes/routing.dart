

part of 'app_pages.dart';

abstract class Routes{
  Routes._();
  static const BASE =_Paths.BASE;
  static const LOGIN =_Paths.LOGIN;
  static const SPLASH =_Paths.SPLASH;
}
abstract class _Paths {
  _Paths._();
  static const BASE ='/base';
  static const LOGIN ='/auth_screen';
  static const SPLASH ='/splash_screen';
}
