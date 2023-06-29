import 'package:flutter/material.dart';
import 'package:mobile/utils/api_service.dart';

import 'package:mobile/utils/app_localizations/app_localizations.dart';
import 'package:mobile/utils/validator.dart';

import 'package:mobile/components/widget_app.dart';
import 'package:mobile/components/widget_form.dart';
import 'package:mobile/components/widget_text_form_field.dart';
import 'package:mobile/components/widget_two_button.dart';

import 'package:mobile/routes.dart';
import 'package:mobile/utils/widgets.dart';

class RecoverPassword extends StatefulWidget {
  const RecoverPassword({Key? key}) : super(key: key);

  @override
  State<RecoverPassword> createState() => _RecoverPasswordState();
}

class _RecoverPasswordState extends State<RecoverPassword> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _formData = {};
  bool state = false;

  String _password = "";
  String _confirmPassword = "";

  @override
  Widget build(BuildContext context) {
    return WidgetApp(
      title: AppLocalizations.of(context)!.recoverPassword,
      children: <Widget>[
        WidgetForm(
          formKey: _formKey,
          children: <Widget>[
            WidgetTextFormField(
              title: AppLocalizations.of(context)!.email,
              keyboardType: TextInputType.emailAddress,
              validator: (value) => Validator.email(context, value!),
              onSaved: (value) => _formData["email"] = value.toString(),
            ),
            if (state) ...[
              WidgetTextFormField(
                title: AppLocalizations.of(context)!.newPassword,
                obscureText: true,
                validator: (value) => Validator.password(context, value!, _confirmPassword),
                onChanged: (value) => _password = value.toString(),
              ),
              WidgetTextFormField(
                title: AppLocalizations.of(context)!.newRepeatPassword,
                obscureText: true,
                validator: (value) => Validator.password(context, _password, value!),
                onChanged: (value) => _confirmPassword = value.toString(),
              ),
              WidgetTextFormField(
                title: AppLocalizations.of(context)!.code,
                keyboardType: TextInputType.number,
                onSaved: (value) => _formData["code"] = value.toString(),
              ),
            ],
          ],
        ),
        const SizedBox(height: 32),
        WidgetTwoButton(
          textLeft: AppLocalizations.of(context)!.recover,
          textRight: AppLocalizations.of(context)!.back,
          buttonLeft: _recuperarSenha,
          buttonRight: (() => AppRoutes.goToConnect(context)),
        ),
      ],
    );
  }

  _recuperarSenha() async {
    _formKey.currentState!.save();

    if (state == false) {
      if (_formKey.currentState!.validate()) {
        state = await ApiService.recoverAccount(_formData["email"]!);
        setState(() {});
      }
    } else {
      if (_formKey.currentState!.validate()) {
        await ApiService.sendRecoverCode(_formData["email"]!, _formData["code"]!, _password);

        WidgetUtils.showMessageSnackBar(_formKey.currentContext!, AppLocalizations.of(context)!.updateSucess);
        AppRoutes.goToConnect(context);
      }
    }
  }
}
