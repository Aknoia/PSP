// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// Project imports:
import 'theme/style.dart';
import 'utils/navigazione.dart';

void main() async {

  /// Inizializzo storage in memoria
  await GetStorage.init();

  RendererBinding.instance.setSemanticsEnabled(true);

  runApp(
    Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          title: 'PLANET SHUTTLE PRO',

          theme: stileApplicazione(),

          onGenerateRoute: (impostazioni) => NavigatorePlanet.mostraNuovaPagina(impostazioni),

          builder: (context, widget) => ResponsiveWrapper.builder(
            BouncingScrollWrapper.builder(context, widget!),

            maxWidth: 1200.0,
            minWidth: 400.0,

            defaultScale: true,

            breakpoints: const [
              ResponsiveBreakpoint.resize(400.0, name: MOBILE),

              ResponsiveBreakpoint.autoScale(600.0, name: TABLET),

              ResponsiveBreakpoint.resize(450.0, name: DESKTOP),
            ],

            background: Container(color: const Color(0xFFF5F5F5)),
          ),

          localizationsDelegates: GlobalMaterialLocalizations.delegates,

          supportedLocales: const [
            Locale('it'),
          ],
        );
      }
    )
  );
}