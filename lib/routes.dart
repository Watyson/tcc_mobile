import 'package:flutter/material.dart';

class AppRoutes {
  static const String connect = "/connect";
  static const String register = "/register";
  static const String recoverPassword = "/recoverPassword";
  static const String menu = "/menu";
  static const String confirmProduct = "/confirmProduct";
  static const String profile = "/profile";
  static const String cart = "/cart";
  static const String historic = "/historic";

  static void goToScreen(BuildContext context, String route, {Object? arguments}) {
    Navigator.pushReplacementNamed(context, route, arguments: arguments);
  }

  static void goToConnect(BuildContext context, {Object? arguments}) {
    Navigator.pushReplacementNamed(context, connect, arguments: arguments);
  }

  static void goToRegister(BuildContext context, {Object? arguments}) {
    Navigator.pushReplacementNamed(context, register, arguments: arguments);
  }

  static void goToRecoverPassword(BuildContext context, {Object? arguments}) {
    Navigator.pushReplacementNamed(context, recoverPassword, arguments: arguments);
  }

  static void goToMenu(BuildContext context, {Object? arguments}) {
    Navigator.pushReplacementNamed(context, menu, arguments: arguments);
  }

  static void goToConfirmProduct(BuildContext context, {Object? arguments}) {
    Navigator.pushReplacementNamed(context, confirmProduct, arguments: arguments);
  }

  static void goToProfile(BuildContext context, {Object? arguments}) {
    Navigator.pushReplacementNamed(context, profile, arguments: arguments);
  }

  static void goToCart(BuildContext context, {Object? arguments}) {
    Navigator.pushReplacementNamed(context, cart, arguments: arguments);
  }

  static void goToHistoric(BuildContext context, {Object? arguments}) {
    Navigator.pushReplacementNamed(context, historic, arguments: arguments);
  }
}
