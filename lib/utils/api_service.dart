import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/models/cart.dart';
import 'package:mobile/models/cart_item.dart';
import 'package:mobile/models/login_response.dart';

import 'package:mobile/models/user.dart';
import 'package:mobile/models/product.dart';
import 'package:mobile/utils/converters/cart.dart';
import 'package:mobile/utils/converters/cart_item.dart';
import 'package:mobile/utils/converters/login_response.dart';

import 'package:mobile/utils/converters/product.dart';
import 'package:mobile/utils/converters/user.dart';

class ApiService {
  static const String _ip = "10.0.2.2";
  static const String _ipServer = "127.0.0.1";
  static const String _port = "8082";

  static const String _addressAPI = "http://$_ip:$_port/api/v1";
  static const Duration _awaitTime = Duration(seconds: 5);

  static late User user;
  static late LoginResponse loginResponseData;
  static late List<Product> products;
  static late Map<int, List<CartItem>> historic;
  static late List<Cart> cart;

  static final _headers = {'Content-Type': 'application/json; charset=UTF-8'};

  static Future<bool> userLogin(username, password) async {
    final url = Uri.parse('$_addressAPI/authenticate/login');
    final body = jsonEncode(<String, String>{'username': username, 'password': password});

    final response = await http.post(url, headers: _headers, body: body).timeout(_awaitTime);
    if (response.statusCode == 200) {
      loginResponseData = LoginResponseConverter.fromJson(json.decode(response.body));
      user = await userRead(loginResponseData);
      return true;
    }
    return false;
  }

  static Future<bool> userLogout() async {
    final url = Uri.parse('$_addressAPI/authenticate/logout/${loginResponseData.id}/${loginResponseData.token}');
    final response = await http.delete(url).timeout(_awaitTime);

    user = User(username: "", password: "", name: "", email: "", address: "", phone: "");
    loginResponseData = LoginResponse(0, "");

    return response.statusCode == 200;
  }

  static Future<bool> userCheckLogin() async {
    final url = Uri.parse('$_addressAPI/authenticate/check/${loginResponseData.id}/${loginResponseData.token}');
    final response = await http.get(url).timeout(_awaitTime);

    return response.statusCode == 200;
  }

  static userRegister(User user) async {
    final url = Uri.parse('$_addressAPI/user/create');
    final body = jsonEncode(UserConverter.toJson(user));

    final response = await http.post(url, headers: _headers, body: body).timeout(_awaitTime);

    return response.statusCode;
  }

  static Future<User> userRead(LoginResponse loginResponse) async {
    final url = Uri.parse('$_addressAPI/user/read/${loginResponse.id}/${loginResponse.token}');
    final response = await http.get(url).timeout(_awaitTime);

    return UserConverter.fromJson(jsonDecode(response.body));
  }

  static userUpdate(User newUser) async {
    final url = Uri.parse('$_addressAPI/user/update/${loginResponseData.id}/${loginResponseData.token}');
    final response = await http
        .put(
          url,
          headers: _headers,
          body: jsonEncode(UserConverter.toJson(newUser)),
        )
        .timeout(_awaitTime);

    user = newUser;

    return response.statusCode == 200;
  }

  static Future<List<Product>> getProducts(int rangeStart, int rangeEnd) async {
    final url = Uri.parse('$_addressAPI/product/read/$rangeStart/$rangeEnd/true');
    final response = await http.get(url).timeout(_awaitTime);

    final List<dynamic> jsonList = jsonDecode(response.body);
    final List<Product> productList = jsonList.map((jsonData) {
      Product product = ProductConverter.fromJson(jsonData);
      product.setImage = 'http://$_ip:$_port/images/${product.image}';
      return product;
    }).toList();

    products = productList;
    return products;
  }

  static Future<List<Product>> confirmPurchased(int rangeStart, int rangeEnd) async {
    final url = Uri.parse('$_addressAPI/product/read/$rangeStart/$rangeEnd/true');
    final response = await http.get(url).timeout(_awaitTime);

    final List<dynamic> jsonList = jsonDecode(response.body);
    final List<Product> productList = jsonList.map((jsonData) {
      return ProductConverter.fromJson(jsonData);
    }).toList();

    products = productList;
    return products;
  }

  static Future<int> addHistoric(Cart cart) async {
    final url = Uri.parse('$_addressAPI/historic/create/${loginResponseData.id}/${loginResponseData.token}');
    final body = jsonEncode(CartConverter.toJson(cart));

    //debugPrint(body);
    final response = await http.post(url, headers: _headers, body: body).timeout(_awaitTime);

    return response.statusCode;
  }

  static Future<Map<int, List<CartItem>>> getHistoric(int rangeStart, int rangeEnd) async {
    final url = Uri.parse('$_addressAPI/historic/read/${loginResponseData.id}/${loginResponseData.token}');
    final response = await http.get(url).timeout(_awaitTime);

    final List<dynamic> jsonList = jsonDecode(response.body);
    final Map<int, List<CartItem>> productList = jsonList.fold({}, (Map<int, List<CartItem>> map, jsonData) {
      final int idPurchase = jsonData['id_purchase'];
      map.putIfAbsent(idPurchase, () => []);
      map[idPurchase]!.add(CartItemConverter.fromJson(jsonData));

      return map;
    });

    historic = productList;
    return historic;
  }

  static Future<bool> recoverAccount(String email) async {
    final url = Uri.parse('http://$_ip:$_port/send_recovery_code');
    final body = jsonEncode(<String, String>{'email': email});

    final response = await http.post(url, headers: _headers, body: body).timeout(_awaitTime);
    return response.statusCode == 200;
  }

  static Future<bool> sendRecoverCode(email, code, password) async {
    final url = Uri.parse('http://$_ip:$_port/change_password/$email/$code/$password');

    final response = await http.get(url, headers: _headers).timeout(_awaitTime);
    return response.statusCode == 200;
  }
}
