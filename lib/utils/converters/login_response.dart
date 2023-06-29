import 'package:mobile/models/login_response.dart';

class LoginResponseConverter {
  static const String idKey = 'id';
  static const String tokenKey = 'token';

  static LoginResponse fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      json[idKey] as int,
      json[tokenKey],
    );
  }

  static Map<String, dynamic> toJson(LoginResponse item) {
    return {
      idKey: item.id,
      tokenKey: item.token,
    };
  }
}
