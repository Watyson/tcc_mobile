import 'package:flutter/material.dart';
import 'dart:async';

import 'package:mobile/utils/api_service.dart';
import 'package:mobile/utils/app_localizations/app_localizations.dart';
import 'package:mobile/utils/converters/user.dart';
import 'package:mobile/utils/validator.dart';
import 'package:mobile/utils/widgets.dart';

import 'package:mobile/components/widget_app_scroll.dart';
import 'package:mobile/components/widget_form.dart';
import 'package:mobile/components/widget_text_form_field.dart';
import 'package:mobile/components/widget_two_button.dart';

import 'package:mobile/routes.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WidgetAppScroll(
      title: AppLocalizations.of(context)!.register,
      children: <Widget>[
        WidgetForm(
          formKey: _formKey,
          children: [
            WidgetTextFormField(
              title: AppLocalizations.of(context)!.username,
              validator: (value) => Validator.username(context, value!),
              onSaved: (value) => _formData["username"] = value!,
            ),
            WidgetTextFormField(
              title: AppLocalizations.of(context)!.password,
              obscureText: true,
              validator: (value) => Validator.password(context, value!, null),
              onSaved: (value) => _formData["password"] = value!,
              onChanged: (value) => _formData["password"] = value!,
            ),
            WidgetTextFormField(
              title: AppLocalizations.of(context)!.repeatPassword,
              obscureText: true,
              validator: (value) => Validator.password(context, value!, _formData["password"]),
              onSaved: (value) => _formData["repeat_password"] = value!,
            ),
            WidgetTextFormField(
              title: AppLocalizations.of(context)!.name,
              validator: (value) => Validator.name(context, value!),
              onSaved: (value) => _formData["name"] = value!,
            ),
            WidgetTextFormField(
              title: AppLocalizations.of(context)!.email,
              keyboardType: TextInputType.emailAddress,
              validator: (value) => Validator.email(context, value!),
              onSaved: (value) => _formData["email"] = value!,
            ),
            WidgetTextFormField(
              title: AppLocalizations.of(context)!.phone,
              keyboardType: TextInputType.phone,
              validator: (value) => Validator.phone(context, value!),
              onSaved: (value) => _formData["phone"] = value!,
            ),
            WidgetTextFormField(
              title: AppLocalizations.of(context)!.address,
              keyboardType: TextInputType.streetAddress,
              validator: (value) => Validator.address(context, value!),
              onSaved: (value) => _formData["address"] = value!,
            ),
          ],
        ),
        const SizedBox(height: 64),
        WidgetTwoButton(
          textLeft: AppLocalizations.of(context)!.register,
          textRight: AppLocalizations.of(context)!.back,
          buttonLeft: _register,
          buttonRight: () => AppRoutes.goToConnect(context),
        ),
      ],
    );
  }

  void _register() async {
    try {
      _formKey.currentState!.save();
      if (_formKey.currentState?.validate() == false) return;

      final response = await ApiService.userRegister(UserConverter.fromJson(_formData));

      if (response != 201) {
        if (response == 422) throw AppLocalizations.of(_formKey.currentContext!)!.errorCreateAccount1;
        throw AppLocalizations.of(_formKey.currentContext!)!.errorCreateAccount;
      }

      AppRoutes.goToConnect(_formKey.currentContext!);
      WidgetUtils.showMessageSnackBar(_formKey.currentContext!, AppLocalizations.of(_formKey.currentContext!)!.registerSucess);
    } catch (e) {
      if (e is TimeoutException) {
        WidgetUtils.showMessageSnackBar(_formKey.currentContext!, AppLocalizations.of(_formKey.currentContext!)!.errorServerDown);
      } else {
        WidgetUtils.showMessageSnackBar(_formKey.currentContext!, e.toString());
      }
    }
  }
}
