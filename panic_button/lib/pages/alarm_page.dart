import 'package:flutter/material.dart';
import 'package:panic_button/widgets/background_widget.dart';
import 'package:panic_button/widgets/text_field_widget.dart';

class AlarmPage extends StatelessWidget {
  AlarmPage({super.key});
  final TextEditingController evDescController = TextEditingController();
  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundWidget(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Card(
                  elevation: 50,
                  shadowColor: Colors.black,
                  color: Colors.greenAccent[100],
                  child: SizedBox(
                    width: 310,
                    height: 290,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.green[500],
                            radius: 123,
                            child: CircleAvatar( child:
                            RichText(
                              text: TextSpan(
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.green[900],
                                fontWeight: FontWeight.w500,
                              ),
                              children: <TextSpan>[
                                TextSpan(text: 'Alarma generada', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                                TextSpan(text: '\n Se enviaron estos datos:\n- Ubicación\n- Video\n- Audio'),
                              ],),
                              textAlign: TextAlign.center,
                              ),
                            radius: 120,
                            backgroundColor: Colors.amber[100],
                            ), 
                          ),
                        ]
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                'Quieres dar más información?',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.green[900],
                  fontWeight: FontWeight.w500,
                ), //Textstyle
              ),
              TextFieldWidget(control: evDescController, texto: "Descripción del Evento"),
              TextFieldWidget(control: commentController, texto: "Comentarios"),
              Padding(
                padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 11, 3, 121)),
                    onPressed: () {
                      
                    },
                    child: const Text("Enviar información", style: TextStyle(color: Colors.white),))),
              ),
              Padding(
                padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 24, 192, 75)),
                    onPressed: () {
                      
                    },
                    child: const Text("Apagar alarma", style: TextStyle(color: Colors.white),))),
              ),
            ],
          )
        ],
      ),
    );
  }
}