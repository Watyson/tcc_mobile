import 'dart:async';

import 'package:flutter/material.dart';

import 'package:mobile/utils/app_localizations/app_localizations.dart';
import 'package:mobile/utils/utils.dart';
import 'package:mobile/utils/validator.dart';
import 'package:mobile/utils/widgets.dart';
import 'package:mobile/utils/api_service.dart';

import 'package:mobile/components/widget_app_scroll.dart';
import 'package:mobile/components/widget_form.dart';
import 'package:mobile/components/widget_row.dart';
import 'package:mobile/components/widget_text.dart';
import 'package:mobile/components/widget_text_form_field.dart';
import 'package:mobile/components/widget_two_button.dart';

import 'package:mobile/models/user.dart';

import 'package:mobile/routes.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  @override
  Widget build(BuildContext context) {
    return WidgetAppScroll(
      title: AppLocalizations.of(context)!.profile,
      children: <Widget>[
        WidgetRow(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buttonLogout(),
            _buttonChangeLanguage(),
          ],
        ),
        _buildUserInfoSection(),
        _buildFormSection(),
        const SizedBox(height: 30),
        WidgetTwoButton(
          textLeft: AppLocalizations.of(context)!.update,
          textRight: AppLocalizations.of(context)!.back,
          buttonLeft: () => _atualizar(),
          buttonRight: () => AppRoutes.goToMenu(context),
        ),
      ],
    );
  }

  Widget _buttonChangeLanguage() {
    final appLocalizations = AppLocalizations.of(context)!;

    return TextButton(
      onPressed: () => setState(() {
        appLocalizations.changeLanguage();
      }),
      child: WidgetText(
        text: appLocalizations.getLanguage(),
        style: const TextStyle(fontSize: 10),
      ),
    );
  }

  Widget _buttonLogout() {
    return TextButton(
      onPressed: () => setState(() {
        try {
          ApiService.userLogout();
          AppRoutes.goToConnect(_formKey.currentContext!);
        } catch (e) {
          if (e is TimeoutException) {
            WidgetUtils.showMessageSnackBar(_formKey.currentContext!, AppLocalizations.of(_formKey.currentContext!)!.errorServerDown);
          } else {
            WidgetUtils.showMessageSnackBar(_formKey.currentContext!, e.toString());
          }
        }
      }),
      child: WidgetText(
        text: AppLocalizations.of(context)!.logout,
        style: const TextStyle(fontSize: 10),
      ),
    );
  }

  Widget _buildUserInfoSection() {
    return WidgetRow(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.account_box, size: 75),
            WidgetText(
              text: Utils.shortenText(ApiService.user.name),
              style: const TextStyle(fontSize: 30),
            ),
            WidgetText(text: ApiService.user.email),
            WidgetText(text: ApiService.user.phone),
            WidgetText(text: ApiService.user.address),
            const SizedBox(height: 25),
          ],
        ),
      ],
    );
  }

  _buildFormSection() {
    return WidgetForm(
      formKey: _formKey,
      children: <Widget>[
        WidgetTextFormField(
          title: AppLocalizations.of(context)!.newEmail,
          keyboardType: TextInputType.emailAddress,
          onSaved: (value) => _formData["email"] = value!,
          validator: (value) {
            if (value != "") return Validator.email(context, value!);
            return null;
          },
        ),
        WidgetTextFormField(
          title: AppLocalizations.of(context)!.newAddress,
          keyboardType: TextInputType.streetAddress,
          onSaved: (value) => _formData["address"] = value!,
          validator: (value) {
            if (value != "") return Validator.address(context, value!);
            return null;
          },
        ),
        WidgetTextFormField(
          title: AppLocalizations.of(context)!.newPhone,
          keyboardType: TextInputType.phone,
          onSaved: (value) => _formData["phone"] = value!,
          validator: (value) {
            if (value != "") return Validator.phone(context, value!);
            return null;
          },
        ),
        WidgetTextFormField(
          title: AppLocalizations.of(context)!.newPassword,
          keyboardType: TextInputType.visiblePassword,
          onSaved: (value) => _formData["password"] = value!,
          onChanged: (value) => _formData["password"] = value!,
          validator: (value) {
            if (value != "") return Validator.password(context, value!, null);
            return null;
          },
        ),
        WidgetTextFormField(
          title: AppLocalizations.of(context)!.newRepeatPassword,
          onSaved: (value) => _formData["repeat_password"] = value!,
          obscureText: true,
          validator: (v) {
            if (v != "") return Validator.password(context, v!, _formData["password"]);
            return null;
          },
        ),
      ],
    );
  }

  void _atualizar() async {
    try {
      _formKey.currentState!.save();
      if (!_formKey.currentState!.validate()) return;
      if (!context.mounted) return;

      final User newUser = ApiService.user;
      newUser.update(_formData, context);

      final response = await ApiService.userUpdate(newUser);

      if (response) {
        setState(() {
          _formKey.currentState!.reset();
        });
        WidgetUtils.showMessageSnackBar(_formKey.currentContext!, AppLocalizations.of(_formKey.currentContext!)!.updateSucess);
      } else {
        WidgetUtils.showMessageSnackBar(_formKey.currentContext!, AppLocalizations.of(_formKey.currentContext!)!.errorUpdate);
      }
    } catch (e) {
      if (e is TimeoutException) {
        WidgetUtils.showMessageSnackBar(_formKey.currentContext!, AppLocalizations.of(_formKey.currentContext!)!.errorServerDown);
      } else {
        WidgetUtils.showMessageSnackBar(_formKey.currentContext!, e.toString());
      }
    }
  }
}
