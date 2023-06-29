import 'package:flutter/material.dart';
import 'package:mobile/components/widget_row.dart';
import 'package:mobile/components/widget_text.dart';
import 'package:mobile/data.dart';
import 'package:mobile/models/cart.dart';
import 'dart:async';

import 'package:mobile/utils/api_service.dart';
import 'package:mobile/utils/app_localizations/app_localizations.dart';
import 'package:mobile/utils/widgets.dart';

import 'package:mobile/components/widget_app.dart';
import 'package:mobile/components/widget_elevated_button.dart';
import 'package:mobile/components/widget_form.dart';
import 'package:mobile/components/widget_text_form_field.dart';
import 'package:mobile/components/widget_two_button.dart';

import 'package:mobile/routes.dart';

class Connect extends StatefulWidget {
  const Connect({Key? key}) : super(key: key);

  @override
  State<Connect> createState() => _ConnectState();
}

class _ConnectState extends State<Connect> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  @override
  Widget build(BuildContext context) {
    return WidgetApp(
      showBar: false,
      children: <Widget>[
        WidgetForm(
          formKey: _formKey,
          children: <Widget>[
            _buttonChangeLanguage(),
            WidgetTextFormField(
              title: AppLocalizations.of(context)!.username,
              onSaved: (value) => _formData["username"] = value!,
            ),
            WidgetTextFormField(
              title: AppLocalizations.of(context)!.password,
              obscureText: true,
              onSaved: (value) => _formData["password"] = value!,
            ),
          ],
        ),
        const SizedBox(height: 32),
        WidgetElevatedButton(
          minimumSize: const Size(200, 40),
          text: AppLocalizations.of(context)!.connect,
          onPressed: () => _connect(),
        ),
        const SizedBox(height: 8),
        WidgetTwoButton(
          textLeft: AppLocalizations.of(context)!.register,
          textRight: AppLocalizations.of(context)!.recoverPassword,
          buttonLeft: () => AppRoutes.goToRegister(context),
          buttonRight: () => AppRoutes.goToRecoverPassword(context),
        ),
      ],
    );
  }

  void _connect() async {
    try {
      _formKey.currentState!.save();

      final username = _formData["username"];
      final password = _formData["password"];
      if (username == "" || password == "") throw (AppLocalizations.of(context)!.errorEmptyLogin);

      final isValid = await ApiService.userLogin(username!, password!);
      if (!isValid) throw AppLocalizations.of(_formKey.currentContext!)!.errorInvalidData;
      Data.cart = Cart();

      AppRoutes.goToMenu(_formKey.currentContext!);
    } catch (e) {
      if (e is TimeoutException) {
        WidgetUtils.showMessageSnackBar(_formKey.currentContext!, AppLocalizations.of(_formKey.currentContext!)!.errorServerDown);
      } else {
        WidgetUtils.showMessageSnackBar(_formKey.currentContext!, e.toString());
      }
    }
  }

  Widget _buttonChangeLanguage() {
    final appLocalizations = AppLocalizations.of(context)!;

    return WidgetRow(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () => setState(() {
            appLocalizations.changeLanguage();
          }),
          child: WidgetText(
            text: appLocalizations.getLanguage(),
            style: const TextStyle(fontSize: 10),
          ),
        ),
      ],
    );
  }
}
