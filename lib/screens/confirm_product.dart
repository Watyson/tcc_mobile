import 'package:flutter/material.dart';
import 'package:mobile/data.dart';
import 'package:mobile/utils/app_localizations/app_localizations.dart';
import 'package:mobile/utils/widgets.dart';

import 'package:mobile/models/product.dart';
import 'package:mobile/routes.dart';

import 'package:mobile/components/widget_app_scroll.dart';
import 'package:mobile/components/widget_row.dart';
import 'package:mobile/components/widget_text.dart';
import 'package:mobile/components/widget_text_form_field.dart';
import 'package:mobile/components/widget_two_button.dart';
import 'package:mobile/components/widget_imagem.dart';

class ConfirmProduct extends StatefulWidget {
  const ConfirmProduct({Key? key}) : super(key: key);

  @override
  State<ConfirmProduct> createState() => _ConfirmProductState();
}

class _ConfirmProductState extends State<ConfirmProduct> {
  late int _quantity = 1;
  late String _observations = "";

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)?.settings.arguments as Product;

    return WidgetAppScroll(
      title: product.name,
      children: <Widget>[
        _buildProductDescription(product),
        const SizedBox(height: 25),
        _buildAmount(),
        const SizedBox(height: 25),
        WidgetTextFormField(title: AppLocalizations.of(context)!.observations, onSaved: (value) => _observations = value!),
        const SizedBox(height: 25),
        _buildConfirmationButtons(product),
      ],
    );
  }

  Widget _buildProductDescription(Product product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        WidgetImage(
          url: product.image,
          width: 300,
          height: 300 / 1.5,
        ),
        const SizedBox(height: 25),
        Text(
          "${AppLocalizations.of(context)!.description}: ${product.description}",
          style: const TextStyle(fontSize: 17),
        ),
        const SizedBox(height: 25),
        Text(
          "${AppLocalizations.of(context)!.finalPrice}: ${AppLocalizations.of(context)!.moneySymbol} ${(_quantity * product.price).toStringAsFixed(2)}",
          style: const TextStyle(fontSize: 23),
        ),
      ],
    );
  }

  Widget _buildAmount() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        WidgetText(text: AppLocalizations.of(context)!.amount),
        WidgetRow(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(icon: const Icon(Icons.arrow_back_ios_new_rounded), onPressed: () => _changeQuantity(-1)),
            Text(_quantity.toString(), style: const TextStyle(fontSize: 20)),
            IconButton(icon: const Icon(Icons.arrow_forward_ios_rounded), onPressed: () => _changeQuantity(1)),
          ],
        ),
      ],
    );
  }

  Widget _buildConfirmationButtons(Product product) {
    return WidgetTwoButton(
      textLeft: AppLocalizations.of(context)!.confirm,
      textRight: AppLocalizations.of(context)!.back,
      buttonLeft: () => _addToCart(product),
      buttonRight: () => AppRoutes.goToMenu(context),
    );
  }

  void _addToCart(Product product) {
    Data.cart.addItem(product, _quantity, _observations);

    AppRoutes.goToMenu(context);
    WidgetUtils.showMessageSnackBar(context, AppLocalizations.of(context)!.addCartSucess);
  }

  void _changeQuantity(int delta) {
    setState(() {
      final newQuantity = _quantity + delta;
      if (newQuantity > 0 && newQuantity < 11) {
        _quantity = newQuantity;
      }
    });
  }
}
