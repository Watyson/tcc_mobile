import 'package:flutter/material.dart';
import 'package:mobile/components/widget_row.dart';

class WidgetContainerRow extends StatelessWidget {
  final List<Widget> children;
  final double? height;
  final double? width;
  final bool border;

  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const WidgetContainerRow({
    Key? key,
    this.children = const [],
    this.height,
    this.width,
    this.border = false,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: border ? Border.all(color: Colors.grey, width: 1) : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: WidgetRow(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: children,
      ),
    );
  }
}
