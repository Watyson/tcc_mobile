import 'package:flutter/material.dart';
import 'package:mobile/components/widget_app_bar.dart';

class WidgetAppScroll extends StatelessWidget {
  final String title;
  final dynamic icon1;
  final dynamic icon2;
  final List<Widget> children;

  const WidgetAppScroll({
    super.key,
    this.title = "",
    this.icon1 = const SizedBox(width: 48),
    this.icon2 = const SizedBox(width: 48),
    this.children = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetAppBar(title: title, icon1: icon1, icon2: icon2),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children,
          ),
        ),
      ),
    );
  }
}
