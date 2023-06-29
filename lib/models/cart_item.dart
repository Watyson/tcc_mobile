import 'package:flutter/material.dart';
import 'package:mobile/models/product.dart';
import 'package:mobile/utils/app_localizations/app_localizations.dart';

class CartItem {
  final String name;
  final double price;
  final String description;
  final String image;
  final String date;
  final int quantity;
  final String observation;
  final int status;
  final String paymentType;
  final int idPurchase;

  CartItem({
    required this.name,
    required this.price,
    required this.description,
    required this.image,
    required this.date,
    required this.quantity,
    required this.observation,
    required this.status,
    required this.paymentType,
    required this.idPurchase,
  });

  double get totalPrice => price * quantity;

  static CartItem productToCartItem(Product product, int quantity, String observation, String payment, int idPurchase) {
    return CartItem(
      name: product.name,
      price: product.price,
      description: product.description,
      image: product.image,
      date: DateTime.now().toString(),
      quantity: quantity,
      observation: observation,
      status: 0,
      paymentType: payment,
      idPurchase: idPurchase,
    );
  }

  String statusText(BuildContext context) {
    switch (status) {
      case 0:
        return AppLocalizations.of(context)!.underReview;
      case 1:
        return AppLocalizations.of(context)!.inPreparation;
      case 2:
        return AppLocalizations.of(context)!.onTheWay;
      case 3:
        return AppLocalizations.of(context)!.delivered;
      case 4:
        return AppLocalizations.of(context)!.canceled;
      default:
        return "";
    }
  }
}
