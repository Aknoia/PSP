// Project imports:
import 'farmacia.dart';


class PlanetConfig {

  List<Farmacia> listaFarmacie;

  String url;

  PlanetConfig(this.listaFarmacie, this.url);
  
  factory PlanetConfig.fromJSON(Map<String, dynamic> json) {
    List<Farmacia> tmpList = List.generate(json['farmacie'].length, (index) => Farmacia.fromJSON(json['farmacie'][index]));

    return PlanetConfig(tmpList, json['url']);
  }


  Map<String, dynamic> toJson() => {
    'farmacie' : listaFarmacie,
    'url': url,
  };
}