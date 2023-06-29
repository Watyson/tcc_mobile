import 'package:flutter/material.dart';
import 'package:mobile/components/widget_column.dart';
import 'package:mobile/components/widget_app_bar.dart';

class WidgetApp extends StatelessWidget {
  final String title;
  final dynamic icon1;
  final dynamic icon2;
  final List<Widget> children;
  final bool showBar;

  const WidgetApp({
    super.key,
    this.title = "",
    this.icon1 = const SizedBox(width: 48),
    this.icon2 = const SizedBox(width: 48),
    this.children = const [],
    this.showBar = true,
  });

  @override
  Widget build(BuildContext context) {
    if (showBar) {
      return Scaffold(
        appBar: WidgetAppBar(title: title, icon1: icon1, icon2: icon2),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: WidgetColumn(children: children),
        ),
      );
    }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: WidgetColumn(children: children),
      ),
    );
  }
}
