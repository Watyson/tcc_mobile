import 'package:flutter/material.dart';
import 'package:mobile/components/widget_column.dart';
import 'package:mobile/components/widget_imagem.dart';
import 'package:mobile/components/widget_row.dart';
import 'package:mobile/components/widget_text.dart';
import 'package:mobile/models/product.dart';

class WidgetIconFood extends StatelessWidget {
  final Product product;
  final double imageWidth;

  const WidgetIconFood({
    Key? key,
    required this.product,
    this.imageWidth = 150,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WidgetRow(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: WidgetImage(
            url: product.image,
            width: imageWidth,
            height: imageWidth / 1.5,
          ),
        ),
        SizedBox(
          width: 225,
          child: WidgetColumn(
            children: [
              WidgetText(
                text: product.name,
                style: const TextStyle(fontSize: 18),
              ),
              WidgetText(
                text: "R\$ ${product.price.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
