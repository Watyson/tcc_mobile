import 'package:flutter/material.dart';
import 'package:mobile/utils/app_localizations/app_localizations.dart';

class User {
  final String _username;
  late String _password;
  final String _name;
  late String _email;
  late String _address;
  late String _phone;
  final List<String> _paymentMethods;

  User({
    required String username,
    required String password,
    required String name,
    required String email,
    required String address,
    required String phone,
    List<String>? paymentMethods,
  })  : _username = username,
        _password = password,
        _name = name,
        _email = email,
        _address = address,
        _phone = phone,
        _paymentMethods = paymentMethods ?? [];

  String get username => _username;
  String get password => _password;
  String get name => _name;
  String get email => _email;
  String get address => _address;
  String get phone => _phone;
  List<String> get paymentMethods => _paymentMethods;

  void update(Map<String, String> newData, BuildContext context) {
    bool verify = false;

    String validator(String a, String? b) {
      if (b == "" || b == null) return a;
      verify = true;
      return b;
    }

    _password = validator(_password, newData["password"]);
    _email = validator(_email, newData["email"]);
    _address = validator(_address, newData["address"]);
    _phone = validator(_phone, newData["phone"]);

    if (!verify) throw AppLocalizations.of(context)!.errorUpdate2;
  }

  void addPaymentMethod(String method) {
    _paymentMethods.add(method);
  }

  void removePaymentMethod(String method) {
    _paymentMethods.remove(method);
  }
}
