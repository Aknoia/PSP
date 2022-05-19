// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:flutter/material.dart';



class DemoLocalizations {
  DemoLocalizations(this.locale);

  final Locale locale;

  static DemoLocalizations? of(BuildContext context) => Localizations.of<DemoLocalizations>(context, DemoLocalizations);

}

class DemoLocalizationsDelegate extends LocalizationsDelegate<DemoLocalizations> {
  const DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['it'].contains(locale.languageCode);

  @override
  Future<DemoLocalizations> load(Locale locale) => SynchronousFuture<DemoLocalizations>(DemoLocalizations(locale));


  @override
  bool shouldReload(DemoLocalizationsDelegate old) => false;
}
