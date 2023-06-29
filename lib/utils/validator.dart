import 'package:flutter/material.dart';
import 'package:mobile/utils/app_localizations/app_localizations.dart';

class Validator {
  Validator._();

  static String? username(BuildContext context, String username) {
    if (username.length < 4) {
      return AppLocalizations.of(context)!.validateUsername;
    }
    return null;
  }

  static String? password(BuildContext context, String password, String? confirmPassword) {
    if (password.length < 8) {
      return AppLocalizations.of(context)!.validatePassword1;
    }
    if (confirmPassword != null && password != confirmPassword) {
      return AppLocalizations.of(context)!.validatePassword2;
    }
    return null;
  }

  static String? name(BuildContext context, String name) {
    if (name.isEmpty) {
      return AppLocalizations.of(context)!.validateName;
    }
    return null;
  }

  static String? email(BuildContext context, String email) {
    try {
      final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!regex.hasMatch(email)) {
        return AppLocalizations.of(context)!.validateEmail;
      }
    } catch (e) {
      return AppLocalizations.of(context)!.validateEmail;
    }
    return null;
  }

  static String? address(BuildContext context, String address) {
    if (address.isEmpty) {
      return AppLocalizations.of(context)!.validateAddress;
    }
    return null;
  }

  static String? phone(BuildContext context, String phone) {
    try {
      final regex = RegExp(r'^\+?\d{9,15}$');
      if (!regex.hasMatch(phone)) {
        return AppLocalizations.of(context)!.validatePhone;
      }
    } catch (e) {
      return AppLocalizations.of(context)!.validatePhone;
    }
    return null;
  }
}
