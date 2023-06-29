import 'package:flutter/material.dart';
import 'package:mobile/components/widget_column.dart';
import 'package:mobile/components/widget_container_column.dart';
import 'package:mobile/components/widget_container_row.dart';
import 'package:mobile/components/widget_row.dart';
import 'package:mobile/components/widget_text.dart';
import 'package:mobile/models/cart_item.dart';
import 'package:mobile/routes.dart';
import 'package:mobile/components/widget_app.dart';
import 'package:mobile/utils/api_service.dart';
import 'package:mobile/utils/app_localizations/app_localizations.dart';
import 'package:intl/intl.dart';

class Historic extends StatefulWidget {
  const Historic({Key? key}) : super(key: key);

  @override
  State<Historic> createState() => _HistoricState();
}

class _HistoricState extends State<Historic> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    ApiService.getHistoric(0, 100).then((historic) {
      setState(() {
        ApiService.historic = historic;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WidgetApp(
      title: AppLocalizations.of(context)!.historic,
      children: <Widget>[
        Expanded(child: _isLoading ? const CircularProgressIndicator() : _buildHistoricListView()),
        const Divider(color: Colors.black, height: 16),
        _buildVoltarButton(),
        const SizedBox(height: 50),
      ],
    );
  }

  Widget _buildHistoricListView() {
    return ListView.separated(
      padding: const EdgeInsets.all(10),
      shrinkWrap: true,
      itemCount: ApiService.historic.values.length,
      separatorBuilder: (context, __) => const Divider(height: 25),
      itemBuilder: (context, index) {
        final List<CartItem> items = ApiService.historic.values.elementAt(index);

        return WidgetContainerColumn(
          width: MediaQuery.of(context).size.width * 0.85,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildHistoricRow(items[0]),
            const SizedBox(height: 4),
            WidgetContainerColumn(
              border: true,
              children: [
                _buildHistoricData(items),
                const Divider(color: Colors.black, height: 4, thickness: 0.5),
                _buildHistoricProductsListView(items),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildHistoricRow(CartItem cart) {
    final text = AppLocalizations.of(context)!;

    return WidgetContainerRow(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      border: true,
      children: [
        WidgetText(text: " ${text.order} ${cart.idPurchase.toString().padLeft(10, '0')}", style: const TextStyle(fontSize: 19)),
        WidgetText(text: " ${text.status}: ${cart.statusText(context)} ", style: const TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _buildHistoricData(List<CartItem> purshase) {
    final text = AppLocalizations.of(context)!;
    final purchaseDate = DateTime.parse(purshase[0].date).toLocal();

    double price = 0;
    for (int i = 0; i < purshase.length; ++i) {
      price += purshase[i].totalPrice;
    }

    return WidgetContainerRow(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        WidgetColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WidgetRow(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                WidgetText(text: "  ${text.date}: ${DateFormat('yyyy-MM-dd').format(purchaseDate)}", style: const TextStyle(fontSize: 19)),
                WidgetText(text: "  ${text.hour}: ${DateFormat('HH:mm:ss').format(purchaseDate)}", style: const TextStyle(fontSize: 19)),
              ],
            ),
            WidgetText(text: "  ${text.totalPrice}${price.toStringAsFixed(2)}", style: const TextStyle(fontSize: 19)),
          ],
        ),
      ],
    );
  }

  Widget _buildHistoricProductsListView(List<CartItem> purshase) {
    final text = AppLocalizations.of(context)!;

    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(10),
      shrinkWrap: true,
      itemCount: purshase.length,
      separatorBuilder: (ctx, __) => const Divider(height: 10),
      itemBuilder: (ctx, index) {
        return WidgetColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(purshase[index].name, style: const TextStyle(fontSize: 20)),
            WidgetRow(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                WidgetText(text: "${text.quantity}: ${purshase[index].quantity}"),
                WidgetText(text: "${text.und} ${text.moneySymbol} ${purshase[index].price.toStringAsFixed(2)}"),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildVoltarButton() {
    final text = AppLocalizations.of(context)!;

    return ElevatedButton(
      style: ButtonStyle(minimumSize: MaterialStateProperty.all(const Size(400, 40))),
      onPressed: () => {AppRoutes.goToCart(context)},
      child: WidgetText(text: text.back, style: const TextStyle(color: Colors.white, fontSize: 20)),
    );
  }
}
