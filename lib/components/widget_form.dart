import 'package:flutter/material.dart';

class WidgetForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final List<Widget> children;

  const WidgetForm({
    super.key,
    required this.formKey,
    this.children = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(children: children),
    );
  }
}
