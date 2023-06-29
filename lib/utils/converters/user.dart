import 'package:mobile/models/user.dart';

class UserConverter {
  static const String _usernameKey = 'username';
  static const String _passwordKey = 'password';
  static const String _nameKey = 'name';
  static const String _emailKey = 'email';
  static const String _addressKey = 'address';
  static const String _phoneKey = 'phone';
  static const String _paymentMethodsKey = 'payment_methods';

  static User fromJson(Map<String, dynamic> json) {
    return User(
      username: json[_usernameKey],
      password: json[_passwordKey],
      name: json[_nameKey],
      email: json[_emailKey],
      address: json[_addressKey],
      phone: json[_phoneKey],
      paymentMethods: List<String>.from(json[_paymentMethodsKey] ?? []),
    );
  }

  static Map<String, dynamic> toJson(User user) {
    return {
      _usernameKey: user.username,
      _passwordKey: user.password,
      _nameKey: user.name,
      _emailKey: user.email,
      _addressKey: user.address,
      _phoneKey: user.phone,
      _paymentMethodsKey: user.paymentMethods,
    };
  }
}
