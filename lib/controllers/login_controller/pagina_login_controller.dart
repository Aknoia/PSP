// Dart imports:
import 'dart:convert';

// Flutter imports.
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import '../../modelli/planet_config.dart';
import '../../modelli/farmacia.dart';
import '../../utils/impostazioni.dart';

class LoginController extends GetxController with StateMixin {

  Rx<PlanetConfig> planetConfig = Rx<PlanetConfig>(PlanetConfig([], ''));

  RxBool nessunConfig = RxBool(true);

  RxList<Farmacia> listaFarmacie = RxList([]);

  Map<String, dynamic> cosmofarma = {'nome':'COSMOFARMA 2021','user':'','token':'','url':'91.81.116.181:6100','resource':'/api','login':'/login'};

  Map<String, dynamic> testGlobale = {'nome':'FARMACIA TEST SITEAM','user':'','token':'','url':'192.168.6.2:8080', 'resource' : '/api', 'login':'/login'};

  @override
  void onInit() {
    super.onInit();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    getConfig();
  }




  Future<void> getConfig() async {
    try {
      change([], status: RxStatus.loading());
      PlanetConfig config = PlanetConfig.fromJSON(json.decode(await DatiUtente.recuperaConfigPlanet()));

      if (config.listaFarmacie.isNotEmpty) {
        nessunConfig.value = false;
      }

      if (kDebugMode) {
        config.listaFarmacie.addIf(!config.listaFarmacie.contains(Farmacia.fromJSON(testGlobale)), Farmacia.fromJSON(testGlobale));
        config.listaFarmacie.addIf(!config.listaFarmacie.contains(Farmacia.fromJSON(cosmofarma)), Farmacia.fromJSON(cosmofarma));
      }

      planetConfig.value = config;
      listaFarmacie.value = config.listaFarmacie;
      change([], status: RxStatus.success());

    } catch (e) {
      change([], status: RxStatus.error(e.toString()));
    }
  }
}