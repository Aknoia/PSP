// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';


// Project imports:
import '../schermi/pagina_login/pagina_login.dart';
import '../schermi/leggi_qr_code/qr_code_scan.dart';
import '../schermi/elenco/elenco.dart';
import '../schermi/stati_cassa/stati_cassa.dart';
import '../schermi/stati_cassa/vendite/storico_vendite.dart';
import '../schermi/stati_cassa/vendite/vendite_utenti.dart';
import '../schermi/promemoria/promemoria.dart';
import '../schermi/menu_statistiche/menu_statistiche.dart';
import '../schermi/advisor/giacenze_rettificate.dart';
import '../schermi/advisor/advisor_menu.dart';
import '../schermi/ordine_provvisorio/ordine_provvisorio.dart';
import '../schermi/rss/rss.dart';
import '../schermi/zoom/sub_screens/scheda_prodotto_zoom.dart';
import '../schermi/zoom/zoom.dart';
import '../schermi/pagina_crediti/pagina_crediti.dart';
import '../schermi/zoom/sub_screens/inserisci_postit.dart';
import '../schermi/menu_statistiche/pagina_statistiche.dart';
import '../schermi/ordine_provvisorio/modifica_ordine.dart';
import '../schermi/ordine_provvisorio/aggiungi_ordine.dart';
import '../schermi/menu_statistiche/dettaglio_statistiche.dart';

import '../bindings/login_bindings/login_bindings.dart';
import '../bindings/login_bindings/qrcode_binding.dart';
import '../bindings/elenco_binding/elenco_binding.dart';
import '../bindings/stati_cassa_binding/vendite_utenti_binding.dart';
import '../bindings/stati_cassa_binding/storico_vendite_binding.dart';
import '../bindings/elenco_binding/giacenze_rettificate_binding.dart';
import '../bindings/zoom_binding/scheda_prodotto_binding.dart';
import '../bindings/zoom_binding/inserisci_posttit_binding.dart';
import '../bindings/rss_binding/rss_binding.dart';
import '../bindings/statistiche_binding/statistiche_binding.dart';
import '../bindings/ordine_provvisorio_binding/modifica_ordine_bindings.dart';
import '../bindings/ordine_provvisorio_binding/aggiungi_ordine_binding.dart';

import '../defaultsWidgets/widget_vedi_html.dart';

class NavigatorePlanet {

  /// Percorsi delle pagine
  static const String homepage = '/homepage';
  static const String login = '/';
  static const String qrcode = '/qrcode';
  static const String statiCassa = '/staticassa';
  static const String storicoVendite = '/storicovendite';
  static const String dettaglioStoricoUtente = '/dettagliostoricoutente';
  static const String venditeUtenti = '/venditeutenti';
  static const String crediti = '/crediti';
  static const String rss = '/rss';
  static const String giacRettificate = '/giacRettificate';
  static const String vediHTML = '/vedihtml';
  static const String schedaProdotto = '/schedaprodotto';
  static const String inserisciPostIT = '/inseriscipostit';
  static const String paginaStatistiche = '/paginastatistiche';
  static const String dettaglioStatistica = '/dettagliostatistica';
  static const String modificaOrdine = '/modificaordine';
  static const String aggiungiOrdine = '/aggiungiordine';

  /// Pagine accessibili dal drawer di Elenco
  static List<Widget> listaPagineDrawer = const [
    StatiCassa(),
    MenuStatistiche(),
    AdvisorMenu(),
    OrdineProvvisorio(),
    Promemoria(),
    RSS(),
    Zoom(),
  ];

  /// OnGenerateRoute
  static Route<dynamic> mostraNuovaPagina(impostazioni) {
    switch(impostazioni.name) {
      case NavigatorePlanet.homepage:
        return GetPageRoute(
          page: () => const Elenco(),
          binding: ElencoBindings(impostazioni.arguments[0]),
        );


      case NavigatorePlanet.login:
        return GetPageRoute(
          page: () => const PaginaLogin(),
          binding: LoginBindings(),
        );


      case NavigatorePlanet.qrcode:
        return GetPageRoute(
          page: () => const QRCodeScan(),
          binding: QRCodeBindings(),
        );


      case NavigatorePlanet.venditeUtenti:
        return GetPageRoute(
          page: () => const VenditeUtenti(),
          binding: VenditeUtentiBinding(periodo: impostazioni.arguments),
        );


      case NavigatorePlanet.storicoVendite:
        return GetPageRoute(
          page: () => const StoricoVendite(),
          binding: StoricoVenditeBinding(),
        );


      case NavigatorePlanet.dettaglioStoricoUtente:
        return GetPageRoute(
          page: () => DettaglioRigheVenditeUtenti2(
            storicovendite: impostazioni.arguments[0],
            nomeUtente: impostazioni.arguments[1],
          ),
          binding: StoricoVenditeBinding(),
        );


      case NavigatorePlanet.rss:
        return GetPageRoute(
          page: () => const RSS(),
          binding: RSSBinding(),
        );


      case NavigatorePlanet.giacRettificate:
        return GetPageRoute(
          page: () => const AdvisorGiacenzeRettificate(),
          binding: GiacenzeRettBinding(),
        );


      case NavigatorePlanet.schedaProdotto:
        return GetPageRoute(
          page: () => const SchedaProdottoZoom(),
          binding: SchedaProdottoBinding(impostazioni.arguments),
        );


      case NavigatorePlanet.inserisciPostIT:
        return GetPageRoute(
          page: () => const PaginaInserisciPostIT(),
          binding: InserisciPostITBinding(impostazioni.arguments[0], impostazioni.arguments[1]),
        );


      case NavigatorePlanet.paginaStatistiche:
        return GetPageRoute(
          page: () => const Statistiche(),
          binding: StatisticheBinding(impostazioni.arguments[0], impostazioni.arguments[1]),
        );


      case NavigatorePlanet.dettaglioStatistica:
        return GetPageRoute(
            page: () => DettaglioStatistica(
              dati: impostazioni.arguments[0],
              tipoReport: impostazioni.arguments[1],
            ),
        );


      case NavigatorePlanet.modificaOrdine:
        Transition transizione;
        Duration durataTransizione = const Duration(milliseconds: 500);

         if (impostazioni.arguments[3] == 'N') {
           durataTransizione = const Duration(milliseconds: 200);
           transizione = Transition.downToUp;
         } else if (impostazioni.arguments[3] == 'L') {
           transizione = Transition.rightToLeft;
         } else {
           transizione = Transition.leftToRight;
         }

        return GetPageRoute(
          page: () => const PaginaModificaOrdine(),
          binding: ModificaOrdineBinding(impostazioni.arguments[0], impostazioni.arguments[1], impostazioni.arguments[2]),
          transition: transizione,
          transitionDuration: durataTransizione,
        );


      case NavigatorePlanet.aggiungiOrdine:
        return GetPageRoute(
          page: () => const AggiungiOrdine(),
          binding: AggiungiOrdineBinding(impostazioni.arguments[0]),
        );


      case NavigatorePlanet.vediHTML:
        return GetPageRoute(page: () => Vedihtml(notizia: impostazioni.arguments));


      case NavigatorePlanet.crediti:
        return GetPageRoute(page: () => const PaginaCrediti());


      default:
        return GetPageRoute(
          page: () => const PaginaLogin(),
          binding: LoginBindings(),
        );
    }
  }
}