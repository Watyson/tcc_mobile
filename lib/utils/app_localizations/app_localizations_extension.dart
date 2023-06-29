import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'app_localizations.dart';

extension LocalizedString on String {
  String localized(AppLocalizations localizations) {
    return localizations.getLocalizedValues(localizations.locale.languageCode)![this]!;
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'pt'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) {
    return false;
  }
}
