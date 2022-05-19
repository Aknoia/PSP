///Prova ad estrarre numeri da una stringa
int estraiNumeriStringa(String stringa) {
  if (stringa.replaceAll(RegExp(r'[^0-9]'), '') == '') {
    return 0;
  }
  return int.tryParse(stringa.replaceAll(RegExp(r'[^0-9]'), ''))!;
}

