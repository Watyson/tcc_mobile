import 'package:flutter/material.dart';
import 'package:mobile/components/widget_text.dart';

class WidgetAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget icon1;
  final Widget icon2;

  const WidgetAppBar({
    Key? key,
    this.title = "",
    this.icon1 = const SizedBox(width: 48),
    this.icon2 = const SizedBox(width: 48),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          PreferredSize(preferredSize: Size.zero, child: icon1),
          WidgetText(text: title),
          PreferredSize(preferredSize: Size.zero, child: icon2),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
