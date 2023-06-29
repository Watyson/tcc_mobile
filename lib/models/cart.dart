import 'dart:math';

import 'package:mobile/models/cart_item.dart';
import 'package:mobile/models/product.dart';

class Cart {
  int idPurchase = 0;
  List<CartItem> items = [];

  reset() {
    idPurchase = 0;
    items.clear();
  }

  itemsCount() {
    return items.length;
  }

  addItem(Product product, int qtd, String obs) {
    if (idPurchase == 0) idPurchase = generateIdRandom();
    items.add(CartItem.productToCartItem(product, qtd, obs, "Dinheiro", idPurchase));
  }

  int generateIdRandom() {
    final random = Random();
    return random.nextInt(2000000000) + 1;
  }

  double getTotalPrice() {
    double price = 0.0;
    for (var item in items) {
      price += item.quantity.toDouble() * item.totalPrice;
    }
    return price;
  }
}