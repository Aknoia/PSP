// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


// Package imports:
import 'package:get/get.dart';

// Project imports:
import '../../../controllers/zoom_controller/inserisci_postit_controller.dart';
import '../../../theme/shapes.dart';
import '../../../defaultsWidgets/widget_pulisci_controller.dart';
import '../../../defaultsWidgets/widget_appbar_back.dart';


class PaginaInserisciPostIT extends GetView<InserisciPostITController> {
  const PaginaInserisciPostIT({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/immagini/scritta.png'),

        leading: const AppbarBackButton(),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: <Widget> [

            const SizedBox(height: 25.0),

            const Text(
              'AGGIUNGI POSTIT',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Form(
              key: controller.chiaveFormPOSTIT,

              child: Column(
                children: <Widget>[

                  /// Descrizione prodotto
                  Card(

                    shape: kCardShape,
                    elevation: 4,

                    child: TextFormField(
                      controller: controller.ctrlDescrizione,
                      readOnly: true,


                      decoration: InputDecoration(
                        labelText: 'Minsan: ${controller.minsan}',
                        labelStyle: const TextStyle(color: Colors.black, fontSize: 20.0),

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



                  ///Quantità
                  Card(
                    elevation: 4.0,
                    shape: kCardShape,

                    child: TextFormField(
                      controller: controller.ctrlQta,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter> [FilteringTextInputFormatter.digitsOnly],

                      decoration: InputDecoration(
                        labelText: 'Pezzi: ',
                        labelStyle: const TextStyle(color: Colors.black, fontSize: 20.0),

                        prefixIcon: Image.asset(
                          'assets/defaultIcons/tastierino.png',
                          color: Colors.green.shade800,
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



                  /// Cliente
                  Card(
                    elevation: 4.0,
                    shape: kCardShape,

                    child: TextFormField(
                      controller: controller.ctrlCliente,
                      keyboardType: TextInputType.name,

                      decoration: InputDecoration(
                        labelText: 'cliente: ',
                        labelStyle: const TextStyle(color: Colors.black, fontSize: 20.0),

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



                  /// Telefono
                  Card(
                    elevation: 4.0,
                    shape: kCardShape,

                    child: TextFormField(
                      controller: controller.ctrlTelefono,
                      keyboardType: TextInputType.phone,
                      inputFormatters: <TextInputFormatter> [FilteringTextInputFormatter.digitsOnly],

                      decoration: InputDecoration(
                        labelText: 'Recapito telefonico: ',
                        labelStyle: const TextStyle(color: Colors.black, fontSize: 20.0),

                        hintText: 'Inserire un recapito telefonico',

                        prefixIcon: Image.asset(
                          'assets/defaultIcons/telefono.png',
                          color: Colors.green.shade800,
                          scale: 1.2,
                        ),

                        suffixIcon: IconaPulisciController(controller: controller.ctrlTelefono),
                      ),

                      validator: (numeroDiTelefono) => numeroDiTelefono!.isEmpty ? 'Campo obbligatorio' : null,
                    ),
                  ),



                  /// Note
                  Card(
                    elevation: 4.0,
                    shape: kCardShape,

                    child: TextFormField(
                      controller: controller.ctrlNote,

                      decoration: InputDecoration(
                        labelText: 'Note prenotazione: ',
                        labelStyle: const TextStyle(color: Colors.black, fontSize: 20.0),

                        hintText: 'Note opzionali',

                        prefixIcon: Image.asset(
                          'assets/defaultIcons/note.png',
                          color: Colors.green.shade800,
                          scale: 1.2,
                        ),

                        suffixIcon: IconaPulisciController(controller: controller.ctrlNote),
                      ),
                    ),
                  ),
                ],
              ),
            ),


            /// Bottone Conferma
            ElevatedButton(
              /// Salva il postit solo in caso di campi validi
              onPressed: () {
                if (controller.chiaveFormPOSTIT.currentState!.validate()) {
                  controller.salvaPostIt();
                  Get.back();
                }
              },

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
    );
  }
}
