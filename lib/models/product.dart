import 'package:flutter/material.dart';
import 'package:mobile/utils/app_localizations/app_localizations.dart';

class Product {
  int _id;
  String _image;
  String _name;
  String _description;
  double _price;
  bool _available;

  Product({
    int id = 0,
    String image = "",
    String name = "",
    String description = "",
    double price = 0.0,
    bool available = false,
  })  : _id = id,
        _image = image,
        _name = name,
        _description = description,
        _price = price,
        _available = available;

  int get id => _id;
  String get image => _image;
  String get name => _name;
  String get description => _description;
  double get price => _price;
  bool get available => _available;

  set setImage(String image) => _image = image;

  void update(Map<String, String> newData, bool? statusInMenu, BuildContext context) {
    bool verify = false;

    String validator(String a, String? b) {
      if (b == "" || b == null) return a;
      verify = true;
      return b;
    }

    _image = validator(_image, newData["image"]);
    _name = validator(_name, newData["name"]);
    _description = validator(_description, newData["description"]);
    _price = double.parse(validator(_price.toString(), newData["price"]));
    if (statusInMenu != null) _available = statusInMenu;

    if (!verify) throw AppLocalizations.of(context)!.errorUpdate2;
  }
}
