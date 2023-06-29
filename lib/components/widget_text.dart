import 'package:flutter/material.dart';

class WidgetText extends StatelessWidget {
  final String text;
  final TextStyle style;

  const WidgetText({
    super.key,
    this.text = "",
    this.style = const TextStyle(fontSize: 17),
  });

  @override
  Widget build(BuildContext context) {
    return Text(text, style: style);
  }
}
