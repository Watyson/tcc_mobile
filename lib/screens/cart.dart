import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile/components/widget_app.dart';
import 'package:mobile/components/widget_column.dart';
import 'package:mobile/components/widget_container.dart';
import 'package:mobile/components/widget_container_row.dart';
import 'package:mobile/components/widget_row.dart';
import 'package:mobile/data.dart';
import 'package:mobile/routes.dart';
import 'package:mobile/utils/api_service.dart';
import 'package:mobile/utils/app_localizations/app_localizations.dart';
import 'package:mobile/components/widget_text_form_field.dart';
import 'package:mobile/components/widget_two_button.dart';
import 'package:mobile/utils/widgets.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final totalMoney = Data.cart.getTotalPrice().toStringAsFixed(2);

    return WidgetApp(
      title: appLocalizations.cart,
      icon2: IconButton(
        icon: const Icon(Icons.history_edu),
        onPressed: () => AppRoutes.goToHistoric(context),
      ),
      children: <Widget>[
        WidgetTextFormField(
          title: appLocalizations.address,
          initialValue: ApiService.user.address,
        ),
        WidgetTextFormField(
          title: appLocalizations.giveMoneyBack,
          initialValue: "0.00",
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
        ),
        const SizedBox(height: 24),
        Text(
          "${appLocalizations.totalMoney} $totalMoney",
          style: const TextStyle(fontSize: 25),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: WidgetContainer(
            border: true,
            child: ListView.separated(
              padding: const EdgeInsets.all(10),
              shrinkWrap: true,
              itemCount: Data.cart.itemsCount(),
              separatorBuilder: (ctx, __) => const Divider(height: 1),
              itemBuilder: (ctx, index) => _buildCartItem(index),
            ),
          ),
        ),
        const SizedBox(height: 50),
        WidgetTwoButton(
          textLeft: appLocalizations.confirm,
          textRight: appLocalizations.back,
          buttonLeft: () => _confirmarCompra(),
          buttonRight: () => AppRoutes.goToMenu(context),
        ),
        const SizedBox(height: 60),
      ],
    );
  }

  Widget _buildCartItem(int index) {
    final cartItem = Data.cart.items[index];
    final appLocalizations = AppLocalizations.of(context)!;

    return WidgetRow(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        WidgetColumn(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            WidgetContainer(
              width: MediaQuery.of(context).size.width * 0.75,
              child: Text(cartItem.name, style: const TextStyle(fontSize: 25)),
            ),
            WidgetContainerRow(
              width: MediaQuery.of(context).size.width * 0.85,
              border: true,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(" ${appLocalizations.qtd} ${cartItem.quantity}", style: const TextStyle(fontSize: 20)),
                Text("${appLocalizations.totalPrice} ${cartItem.totalPrice.toStringAsFixed(2)}", style: const TextStyle(fontSize: 20)),
                IconButton(icon: const Icon(Icons.delete), onPressed: () => _removeItem(index)),
              ],
            ),
            const SizedBox(height: 12),
          ],
        )
      ],
    );
  }

  void _removeItem(int index) {
    setState(() {
      Data.cart.items.removeAt(index);
    });
  }

  void _confirmarCompra() async {
    try {
      if (Data.cart.items.isEmpty) throw AppLocalizations.of(context)!.errorPurshaceEmpty;
      String error = AppLocalizations.of(context)!.errorConnectServer;
      String sucess = AppLocalizations.of(context)!.sucessPurchase;

      if (await ApiService.addHistoric(Data.cart) != 200) throw error;

      setState(() {
        Data.cart.reset();
      });
      throw sucess;
    } catch (e) {
      if (e is TimeoutException) {
        WidgetUtils.showMessageSnackBar(context, AppLocalizations.of(context)!.errorServerDown);
      } else {
        WidgetUtils.showMessageSnackBar(context, e.toString());
      }
    }
  }
}
