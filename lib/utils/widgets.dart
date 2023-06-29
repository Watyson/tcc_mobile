import 'package:flutter/material.dart';

class WidgetUtils {
  WidgetUtils._();

  static void showMessageSnackBar(BuildContext context, String msg) {
    returnMessageSnackBar(context, msg);
  }

  static returnMessageSnackBar(BuildContext context, String msg) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }
}
