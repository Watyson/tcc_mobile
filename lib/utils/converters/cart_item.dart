import 'package:mobile/models/cart_item.dart';

class CartItemConverter {
  static const String nameKey = 'name';
  static const String priceKey = 'price';
  static const String descriptionKey = 'description';
  static const String imageKey = 'image';
  static const String dateKey = 'date';
  static const String quantityKey = 'quantity';
  static const String observationKey = 'observation';
  static const String statusKey = 'status';
  static const String paymentTypeKey = 'payment_type';
  static const String idPurchaseKey = 'id_purchase';

  static CartItem fromJson(Map<String, dynamic> json) {
    return CartItem(
      name: json[nameKey],
      price: json[priceKey],
      description: json[descriptionKey],
      image: json[imageKey],
      date: json[dateKey],
      quantity: json[quantityKey],
      observation: json[observationKey],
      status: json[statusKey],
      paymentType: json[paymentTypeKey],
      idPurchase: json[idPurchaseKey],
    );
  }

  static Map<String, dynamic> toJson(CartItem item) {
    return {
      nameKey: item.name,
      priceKey: item.price,
      descriptionKey: item.description,
      imageKey: item.image,
      dateKey: item.date,
      quantityKey: item.quantity,
      observationKey: item.observation,
      statusKey: item.status,
      paymentTypeKey: item.paymentType,
      idPurchaseKey: item.idPurchase,
    };
  }
}
