import 'package:mobile/models/product.dart';

class ProductConverter {
  static const String _idKey = 'id';
  static const String _imageKey = 'image';
  static const String _nameKey = 'name';
  static const String _descriptionKey = 'description';
  static const String _priceKey = 'price';
  static const String _availableKey = 'available';

  static Product fromJson(Map<String, dynamic> json) {
    return Product(
      id: json[_idKey],
      image: json[_imageKey],
      name: json[_nameKey],
      description: json[_descriptionKey],
      price: json[_priceKey],
      available: json[_availableKey],
    );
  }

  static Map<String, dynamic> toJson(Product product) {
    return {
      _idKey: product.id,
      _imageKey: product.image,
      _nameKey: product.name,
      _descriptionKey: product.description,
      _priceKey: product.price,
      _availableKey: product.available,
    };
  }
}
