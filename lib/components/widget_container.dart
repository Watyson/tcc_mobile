import 'package:flutter/material.dart';

class WidgetContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;
  final bool border;

  const WidgetContainer({
    Key? key,
    required this.child,
    this.height,
    this.width,
    this.border = false,
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
      child: child,
    );
  }
}
