import 'package:flutter/material.dart';
import 'package:mobile/components/widget_text.dart';

class WidgetElevatedButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final Size minimumSize;

  const WidgetElevatedButton({
    super.key,
    this.text = "",
    this.minimumSize = const Size(175, 40),
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(minimumSize: MaterialStateProperty.all(minimumSize),
      maximumSize: MaterialStateProperty.all(minimumSize)),
      onPressed: onPressed,
      child: WidgetText(text: text),
    );
  }
}