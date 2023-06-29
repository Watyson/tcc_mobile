import 'package:flutter/material.dart';
import 'package:mobile/components/widget_elevated_button.dart';
import 'package:mobile/components/widget_row.dart';

class WidgetTwoButton extends StatelessWidget {
  final String textLeft;
  final String textRight;
  final void Function() buttonLeft;
  final void Function() buttonRight;

  const WidgetTwoButton({
    super.key,
    this.textLeft = "",
    this.textRight = "",
    required this.buttonLeft,
    required this.buttonRight,
  });

  @override
  Widget build(BuildContext context) {
    return WidgetRow(
      children: <Widget>[
        WidgetElevatedButton(text: textLeft, onPressed: buttonLeft),
        const SizedBox(width: 32),
        WidgetElevatedButton(text: textRight, onPressed: buttonRight),
      ],
    );
  }
}
