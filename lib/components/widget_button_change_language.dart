import 'package:flutter/material.dart';
import 'package:mobile/components/widget_row.dart';
import 'package:mobile/components/widget_text.dart';
import 'package:mobile/utils/app_localizations/app_localizations.dart';

class ButtonChangeLanguage extends StatefulWidget {
  final BuildContext context;
  final AppLocalizations appLocalizations;

  const ButtonChangeLanguage({
    Key? key,
    required this.context,
    required this.appLocalizations,
  }) : super(key: key);

  @override
  ButtonChangeLanguageState createState() => ButtonChangeLanguageState();
}

class ButtonChangeLanguageState extends State<ButtonChangeLanguage> {
  @override
  Widget build(BuildContext context) {
    return WidgetRow(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            setState(() {
              widget.appLocalizations.changeLanguage();
            });
          },
          child: WidgetText(
            text: widget.appLocalizations.getLanguage(),
            style: const TextStyle(fontSize: 10),
          ),
        ),
      ],
    );
  }
}
