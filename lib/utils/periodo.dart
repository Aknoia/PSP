

class Periodo {

String? annoIn;
String? annoOut;
String? meseIn;
String? meseOut;

int? _meseIn = 0;
int? _meseOut = 0;
int? _annoIn;
int? _annoOut;

List<String>? tipiAnno;

List<String>? tipiMesi;

Periodo () {

  int adesso = DateTime.now().year;

  tipiAnno = [adesso.toString(),(adesso-1).toString(),(adesso-2).toString()];

  tipiMesi = [
    'gennaio',
    'febbraio',
    'marzo',
    'aprile',
    'maggio',
    'giugno',
    'luglio',
    'agosto',
    'settembre',
    'ottobre',
    'novembre',
    'dicembre',

  ];
  meseIn = 'Tutti';
  meseOut = 'Tutti';

  annoIn   = DateTime.now().year.toString();
  annoOut  = (DateTime.now().year).toString();
  _annoIn  = DateTime.now().year;
  _annoOut = DateTime.now().year;
}

void setAnnoIn(String nuovoAnno) {
  annoIn = nuovoAnno;
  _annoIn = tipiAnno?.indexOf(nuovoAnno);
  rendiCongruo();
}

void setAnnoOut(String nuovoAnno) {
  annoOut = nuovoAnno;
  _annoOut = tipiAnno?.indexOf(nuovoAnno);
  rendiCongruo();
}

void setMeseIn(String nuovoMese) {
  meseIn = nuovoMese;
  _meseIn = tipiMesi?.indexOf(nuovoMese);
  rendiCongruo();
}

void setMeseOut(String nuovoMese) {
  meseOut = nuovoMese;
  _meseOut= tipiMesi?.indexOf(nuovoMese);
  rendiCongruo();
}

void rendiCongruo () {
  if ((_meseIn! > 0) && (_meseOut! > 0)) {
    DateTime dataIn = DateTime(_annoIn!,_meseIn!,1);

    DateTime dataOut = DateTime(_annoOut!, _meseOut! + 1, 0);
    if (dataOut.difference(dataIn).isNegative) {
      _meseOut = _meseIn;
      _annoOut = _annoIn;
      meseOut = tipiMesi![_meseOut as int];
      annoOut = tipiAnno![_annoOut as int];
    }
  }
}

String getMeseIn() => (_meseIn == 0) ? '1' : _meseIn.toString();

String getMeseOut() => (_meseOut == 0) ? '12' : _meseOut.toString();


String getDataIn() {
  rendiCongruo();

  if (meseIn == 'Tutti') {
    return '01/01/$_annoIn';
  }
  return '1/$_meseIn/$_annoIn';
}

String getDataOut() {
  rendiCongruo();

  if (meseIn == 'Tutti') {
    return '31/12/$_annoIn';
  }

  if (meseOut =='Tutti') {
    return '31/12/$_annoIn';
  }

  DateTime da = DateTime(
    _annoOut!,
    _meseOut! + 1,
    0,
  );

  return '${da.day}/$_meseOut/$_annoOut';
}
}

class PeriodoData {

  DateTime? dataIn;

  DateTime? dataOut;

  PeriodoData ({int giornoData1 = 0, int meseData1 = 0, int annoData1 = 0, int giornoData2 = 0, int meseData2 = 0, int annoData2 = 0}) {
    if ((giornoData1 == 0) && (meseData1 == 0)) {
      dataIn = DateTime.now();
    } else {
      dataIn = DateTime(
        annoData1,
        meseData1,
        giornoData1,
      );
    }

    if ((giornoData2 == 0) && (meseData2 == 0)) {
      dataOut=DateTime.now();
    } else {
      dataOut = DateTime(
        annoData2,
        meseData2,
        giornoData2,
      );
    }
    rendiCongruo();
  }


  void setD1 (int gData1, int mData1, int aData1) {
    dataIn = DateTime(aData1,mData1,gData1);
  }

  void setD2 (int gData2, int mData2, int aData2){
    dataIn = DateTime(aData2,mData2,gData2);
  }


  void rendiCongruo() {
    if (dataOut!.isBefore(dataIn!))  {
      dataOut = dataIn;
    }
  }

  String getDataIn() {
    rendiCongruo();

    return '${dataIn?.day}/${dataIn?.month}/${dataIn?.year}';
  }

  String getDataOut() {
    rendiCongruo();

    return '${dataOut?.day}/${dataOut?.month}/${dataOut?.year}';
  }



  static PeriodoData creaPeriodoSettimana() {
    DateTime adesso = DateTime.now();

    DateTime indata = adesso.subtract(Duration(days: (adesso.weekday-1)));

    return PeriodoData(
      giornoData1: indata.day,
      meseData1: indata.month,
      annoData1: indata.year,
      giornoData2: adesso.day,
      meseData2: adesso.month,
      annoData2: adesso.year,
    );
  }

  static  PeriodoData creaPeriodoMese() {
    DateTime adesso = DateTime.now();

    DateTime indata = DateTime(adesso.year, adesso.month,1);

    return PeriodoData(
      giornoData1: indata.day,
      meseData1: indata.month,
      annoData1: indata.year,
      giornoData2: adesso.day,
      meseData2: adesso.month,
      annoData2: adesso.year,
    );
  }



}