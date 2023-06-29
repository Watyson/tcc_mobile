import 'package:mobile/models/cart.dart';
import 'package:mobile/utils/converters/cart_item.dart';

class CartConverter {
  static List<dynamic> toJson(Cart cart) {
    List<dynamic> a = List<dynamic>.from(
      cart.items.map(
        (item) => CartItemConverter.toJson(item),
      ),
    );

    return a;
  }
}
