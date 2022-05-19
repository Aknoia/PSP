// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:enum_to_string/enum_to_string.dart';


// Project imports:
import '../../../controllers/stati_cassa_controller/stati_cassa_controller.dart';
import '../../../defaultFunctions/controlla_valore_null.dart';
import '../../../defaultsWidgets/prendi_data.dart';
import '../../../defaultsWidgets/prendi_data_range.dart';
import '../../../theme/dimensioni.dart';
import '../../../theme/shapes.dart';
import '../../../utils/enums.dart';




class InfoIntervalloCassa extends StatelessWidget {
  const InfoIntervalloCassa({Key? key, required this.controller}) : super(key: key);

  final StatiCassaController controller;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      color: Get.theme.scaffoldBackgroundColor,

      shape: kShapeDettVend,

      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[

              Text (
                'Tipo report: ',
                style: TextStyle(fontSize: fontSizeGrande / 1.5),
              ),

              Obx(() =>
                  DropdownButton<String>(
                    value: EnumToString.convertToString(controller.tempoReport),

                    icon: Image.asset(
                      'assets/defaultIcons/doppia_freccia_sotto.png',
                      scale: 2,
                      color: Colors.green.shade800,
                    ),

                    iconSize: 14.0,
                    elevation: 6,

                    style: TextStyle(fontSize: fontSizeGrande / 2.0),

                    underline: Container(
                      height: 2.0,
                      color: Get.theme.selectedRowColor,
                    ),

                    onChanged: (String? nuovoTempoReport) {

                      controller.offsetPeriodo.value = 0;
                      controller.tempoReport = EnumToString.fromString(TempoReport.values, nuovoTempoReport!)!;

                      controller.leggiStatistiche();
                    },

                    items: TempoReport.values.map((tempistica) => DropdownMenuItem(
                      value: EnumToString.convertToString(tempistica),

                      child: Text(
                        EnumToString.convertToString(tempistica),
                        style: TextStyle(
                          fontSize: fontSizeGrande / 1.5,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    ).toList(),
                  ),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[
              Builder(
                  builder: (context) {


                    return Obx(() {
                      switch(controller.tempoReport) {
                        case TempoReport.giorno:
                          if (controller.offsetPeriodo.value == 0) {
                            return Text('Vendite di oggi rispetto a ${EnumToString.convertToString(Giorno.values[controller.giorniPeriodo[1].dataIn!.weekday])} ${controller.giorniPeriodo[1].dataIn!.day}');
                          } else {
                            return Column(
                                children: <Widget> [
                                  Text('Vendite di ${EnumToString.convertToString(Giorno.values[controller.giorniPeriodo[0].dataIn!.weekday])} ${controller.giorniPeriodo[0].dataIn!.day}'),

                                  Text('rispetto a ${EnumToString.convertToString(Giorno.values[controller.giorniPeriodo[1].dataIn!.weekday])} ${controller.giorniPeriodo[1].dataIn!.day}'),
                                ]
                            );
                          }

                        case TempoReport.mese:
                          return Column(
                            children: <Widget>[
                              Text('Vendite di ${EnumToString.convertToString(Mese.values[controller.giorniPeriodo[0].dataIn!.month])} ${controller.giorniPeriodo[0].dataIn!.year}'),

                              Text('confrontate con ${EnumToString.convertToString(Mese.values[controller.giorniPeriodo[1].dataIn!.month])} ${controller.giorniPeriodo[1].dataIn!.year}'),
                            ],
                          );

                        case TempoReport.meseAnnoPrec:
                          return Column(
                            children: <Widget>[
                              Text('Vendite di ${EnumToString.convertToString(Mese.values[controller.giorniPeriodo[0].dataIn!.month])} ${controller.giorniPeriodo[0].dataIn!.year}'),

                              Text('confrontate con ${EnumToString.convertToString(Mese.values[controller.giorniPeriodo[1].dataIn!.month])} ${controller.giorniPeriodo[1].dataIn!.year}'),
                            ],
                          );

                        case TempoReport.intervallo:
                          return Column(
                            children: <Widget>[

                              Text('Vendite da ${EnumToString.convertToString(Giorno.values[controller.giorniPeriodo[0].dataIn!.weekday])} ${controller.giorniPeriodo[0].dataIn!.day} ${EnumToString.convertToString(Mese.values[controller.giorniPeriodo[0].dataIn!.month])}'),

                              Text('a ${EnumToString.convertToString(Giorno.values[controller.giorniPeriodo[0].dataOut!.weekday])} ${controller.giorniPeriodo[0].dataOut!.day} ${EnumToString.convertToString(Mese.values[controller.giorniPeriodo[0].dataOut!.month])}'),
                            ],
                          );

                        case TempoReport.anno:
                          return Column(
                            children: <Widget>[

                              Text('Vendite del ${controller.giorniPeriodo[0].dataIn!.year}'),

                              Text('confrontato con il ${controller.giorniPeriodo[1].dataIn!.year}'),
                            ],
                          );
                      }
                    });
                  }
              ),
            ],
          ),

          const SizedBox(height: 5.0),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,

            children: <TextButton>[
              TextButton(
                onPressed: () {
                  controller.offsetPeriodo.value -= 1;
                  controller.vendite.clear();
                  controller.leggiStatistiche();
                },

                style: TextButton.styleFrom(shape: kCardShape),
                child: Tooltip(
                  message: 'Indietro di uno',
                  child: Image.asset(
                    'assets/defaultIcons/freccia_sinistra.png',
                    scale: 2,
                    color: Colors.green.shade800,
                  ),
                ),
              ),


              TextButton(
                onPressed: () async {
                  switch(controller.tempoReport) {
                    case TempoReport.intervallo:

                      controller.intervallo = await prendiDataRange();
                      controller.offsetPeriodo.value = 0;

                      if (checkValoreNull(controller.intervallo)) {
                        controller.intervallo = [DateTime.now(), DateTime.now()];
                      }
                      break;

                    case TempoReport.giorno:
                      DateTime? md = await prendiData(DatePickerMode.day);

                      controller.offsetPeriodo.value = md.difference(DateTime.now()).inDays;
                      if (controller.offsetPeriodo.value > 0) {
                        controller.offsetPeriodo.value++;
                      }
                      break;

                    case TempoReport.mese:
                      DateTime? md = await prendiData(DatePickerMode.day);
                      controller.offsetPeriodo.value = md.difference(DateTime.now()).inDays;
                      break;

                    case TempoReport.meseAnnoPrec:
                      DateTime md = await prendiData(DatePickerMode.day);
                      controller.offsetPeriodo.value = md.month - DateTime.now().month;
                      break;

                    case TempoReport.anno:
                      DateTime md = await prendiData(DatePickerMode.year);
                      controller.offsetPeriodo.value = md.year - DateTime.now().year;
                      break;
                  }



                  controller.vendite.clear();
                  controller.leggiStatistiche();
                },

                style: TextButton.styleFrom(shape: kCardShape),
                child: Tooltip(
                    message: 'Vai a ',
                    child: Image.asset(
                      'assets/defaultIcons/calendario.png',
                      scale: 2,
                      color: Colors.green.shade800,
                    )
                ),
              ),


              TextButton(
                onPressed: () {
                  controller.offsetPeriodo.value += 1;
                  controller.vendite.clear();
                  controller.leggiStatistiche();
                },

                style: TextButton.styleFrom(shape: kCardShape),
                child:  Tooltip(
                  message: 'Avanti di uno',
                  child: Image.asset(
                    'assets/defaultIcons/freccia_destra.png',
                    scale: 2,
                    color: Colors.green.shade800,
                  ),
                ),
              ),

            ],
          ),

          const SizedBox(
            height: 15.0,
            width: 400.0,
          ),
        ],
      ),
    );
  }
}