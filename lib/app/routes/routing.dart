

part of 'app_pages.dart';

abstract class Routes{
  Routes._();
  static const BASE =_Paths.BASE;
  static const LOGIN =_Paths.LOGIN;
}
abstract class _Paths {
  _Paths._();
  static const BASE ='/base';
  static const LOGIN ='/auth_screen';
}
