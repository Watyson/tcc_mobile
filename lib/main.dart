import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:mobile/routes.dart';
import 'package:mobile/screens/cart.dart';
import 'package:mobile/screens/connect.dart';
import 'package:mobile/screens/confirm_product.dart';
import 'package:mobile/screens/historic.dart';
import 'package:mobile/screens/menu.dart';
import 'package:mobile/screens/profile.dart';
import 'package:mobile/screens/register.dart';
import 'package:mobile/screens/recover_password.dart';
import 'package:mobile/utils/app_localizations/app_localizations_extension.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('pt', 'BR'),
      ],
      theme: ThemeData.light(),
      initialRoute: AppRoutes.connect,
      routes: {
        AppRoutes.connect: (_) => const Connect(),
        AppRoutes.register: (_) => const Register(),
        AppRoutes.recoverPassword: (_) => const RecoverPassword(),
        AppRoutes.menu: (_) => const Menu(),
        AppRoutes.profile: (_) => const Profile(),
        AppRoutes.cart: (_) => const Cart(),
        AppRoutes.confirmProduct: (_) => const ConfirmProduct(),
        AppRoutes.historic: (_) => const Historic(),
      },
    );
  }
}
