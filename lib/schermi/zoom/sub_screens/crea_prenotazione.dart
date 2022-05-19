// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import '../../../controllers/zoom_controller/crea_prenotazione_controller.dart';
import '../../../theme/shapes.dart';
import '../../../defaultsWidgets/widget_pulisci_controller.dart';


class PaginaCreaPrenotazione extends GetView<CreaPrenotazioneController> {
  const PaginaCreaPrenotazione({Key? key, required this.codiceProdotto}) : super(key: key);

  final String? codiceProdotto;

  @override
  Widget build(BuildContext context) {
    Get.put(CreaPrenotazioneController(codiceProdotto!));

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(10.0),

            child: const Text(
              'Crea Prenotazione',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Form(
            key: controller.chiaveFormPrenotazione,

            child: Column(
              children: <Widget>[
                /// Minsan
                Card(

                  shape: kCardShape,
                  elevation: 4,

                  child: TextFormField(
                    controller: controller.ctrlMinsan,
                    readOnly: true,


                    decoration: InputDecoration(
                      labelText: 'Minsan: ',
                      labelStyle: const TextStyle(color: Colors.black, fontSize: 20),

                      prefixIcon: Image.asset(
                        'assets/defaultIcons/carrello.png',
                        color: Colors.green.shade800,
                        scale: 1.2,
                      ),
                    ),

                    /// Valida minsan
                    validator: (minsan) => minsan!.isEmpty ? 'Errore, si prega di ricaricare la pagina.' : null,
                  ),
                ),



                /// Quantità
                Card(
                  shape: kCardShape,
                  elevation: 4,

                  child: TextFormField(
                    controller: controller.ctrlQta,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],

                    decoration: InputDecoration(
                      labelText: 'Pezzi: ',
                      labelStyle: const TextStyle(color: Colors.black, fontSize: 20.0),

                      prefixIcon: Image.asset(
                        'assets/defaultIcons/tastierino.png',
                        color: Colors.green.shade800,
                        scale: 1.2,
                      ),

                      suffixIcon: IconButton(
                        icon: Image.asset(
                          'assets/defaultIcons/cestino.png',
                          color: Colors.red.shade800,
                          scale: 1.2,
                        ),

                        onPressed: () => controller.ctrlQta.text = '1',
                      ),
                    ),


                    /// Valida quantità
                    validator: (qta) => (qta!.isEmpty || (int.parse(qta) <= 0)) ? 'Inserire almeno un prodotto' : null,

                  ),
                ),



                ///Cliente
                Card(
                  shape: kCardShape,
                  elevation: 4.0,

                  child: TextFormField(
                    controller: controller.ctrlCliente,
                    keyboardType: TextInputType.name,

                    decoration: InputDecoration(
                      labelText: 'Cliente: ',
                      labelStyle: const TextStyle(color: Colors.black, fontSize: 20),

                      hintText: 'Inserire nominativo cliente',

                      prefixIcon: Image.asset(
                        'assets/icone/cliente.ico',
                        scale: 9,
                        color: Colors.green.shade800,
                      ),

                      suffixIcon: IconaPulisciController(controller: controller.ctrlCliente),
                    ),

                    /// Valida cliente
                    validator: (cliente) => cliente!.isEmpty ? 'Campo obbligatorio' : null,
                  ),
                ),



                /// Codice Fiscale
                Card(
                  elevation: 4,
                  shape: kCardShape,

                  child: TextFormField(
                      controller: controller.ctrlCodiceFiscale,
                      keyboardType: TextInputType.streetAddress,

                      decoration: InputDecoration(
                        labelText: 'Codice fiscale: ',
                        labelStyle: const TextStyle(color: Colors.black, fontSize: 20),

                        hintText: 'Inserire codice fiscale del cliente',

                        prefixIcon: Image.asset(
                          'assets/defaultIcons/codice_fiscale.png',
                          color: Colors.green.shade800,
                          scale: 1.2,
                        ),

                        suffixIcon: IconaPulisciController(controller: controller.ctrlCodiceFiscale),
                      ),

                      /// Valida codice fiscale
                      validator: (codiceFiscale) {
                        RegExp convalidatoreCodice = RegExp(
                          r'[A-Za-z]{6}[0-9lmnpqrstuvLMNPQRSTUV]{2}[abcdehlmprstABCDEHLMPRST]{1}[0-9lmnpqrstuvLMNPQRSTUV]{2}[A-Za-z]{1}[0-9lmnpqrstuvLMNPQRSTUV]{3}[A-Za-z]{1}',
                          caseSensitive: false,

                        );

                        if (codiceFiscale!.isEmpty) {
                          return 'Campo obbligatorio';
                        } else if (!convalidatoreCodice.hasMatch(codiceFiscale) || (codiceFiscale.isEmpty && codiceFiscale.length >= 17)) {
                          return 'Codice fiscale non valido';
                        }

                        return null;
                      }
                  ),
                ),



                /// Telefono
                Card(
                  elevation: 4,
                  shape: kCardShape,

                  child: TextFormField(
                    controller: controller.ctrlTelefono,
                    keyboardType: TextInputType.phone,
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],

                    decoration: InputDecoration(
                      labelText: 'Recapito telefonico: ',
                      labelStyle: const TextStyle(color: Colors.black, fontSize: 20),

                      hintText: 'Inserire un recapito telefonico',

                      prefixIcon: Image.asset(
                        'assets/defaultIcons/telefono.png',
                        color: Colors.green.shade800,
                        scale: 1.2,
                      ),

                      suffixIcon: IconaPulisciController(controller: controller.ctrlTelefono),
                    ),

                    /// Valida numero di telefono
                    validator: (numeroDiTelefono) => numeroDiTelefono!.isEmpty ? 'Campo obbligatorio' : null,
                  ),
                ),



                /// Note
                Card(
                  elevation: 4,
                  shape: kCardShape,

                  child: TextFormField(
                    controller: controller.ctrlNote,

                    decoration: InputDecoration(
                      labelText: 'Note prenotazione: ',
                      labelStyle: const TextStyle(color: Colors.black, fontSize: 20.0),

                      prefixIcon: Image.asset(
                        'assets/defaultIcons/note.png',
                        color: Colors.green.shade800,
                        scale: 1.2,
                      ),

                      suffixIcon: IconaPulisciController(controller: controller.ctrlNote),
                    ),
                  ),
                ),



                /// Bottone Conferma
                ElevatedButton(
                  //Conferma la prenotazione solo se i campi sono validi
                  onPressed: () => controller.chiaveFormPrenotazione.currentState!.validate() ? controller.confermaPrenotazione() : null,

                  style: ElevatedButton.styleFrom(
                    shape: kCardShape,
                  ),

                  child: Text(
                    'Conferma',
                    style: TextStyle(color: Colors.green.shade800),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}