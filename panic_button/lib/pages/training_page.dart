import 'package:flutter/material.dart';
import 'package:panic_button/widgets/background_widget.dart';

class TrainingPage extends StatelessWidget {
  const TrainingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Panic Button", style: TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: Colors.indigo[900],
        centerTitle: false,
      ),
      body: Stack(children: [
          BackgroundWidget(),
          Column (
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            Center(
              child: SingleChildScrollView(
                child: Card(
                  elevation: 50,
                  shadowColor: Colors.black,
                  color: Colors.greenAccent[100],
                  child: SizedBox(
                    width: 380,
                    height: 600,
                    child: Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(),
                            child: Text(
                              "Compatriota:\n"
                              "Esta app está diseñada para generar alarmas de situaciones cotidianas en las que necesites ayuda.\n\n"
                              "Para gestionar esta ayuda, idealmente necesitamos saber en qué situación en particular te encuentras (robo, accidente, violación sexual...). \n\n"
                              "Sin embargo, hay ocasiones en las que No hay tiempo o espacio disponible para reportar esta información.\n"
                              "Es por eso, que al presionar el botón de pánico (botón rojo), de manera inmediata se transmitirá la ubicación "
                              "y video de este celular a una central.\nPero en vista de que esta información no es suficiente, "
                              "se cuenta con un sistema de reconocimiento de palabras claves para para identificar que tipo de ayuda necesitas.\n\n"
                              "Entonces...\n"
                              "Si te encuentras en un accidente de tránsito y dices alguna de estas frases:\n"
                              "- Jueputa me maté\n"
                              "- Accidente de tránsito\n"
                              "El sistema identificará que se trata de un accidente de tránsito y enviaremos una ambulancia.\n\n"
                              "Si te encuentras en una situación de acoso/violación Sexual o Robo/Hurto y dices alguna de estas frases:\n"
                              "- Señor, me puede decir la hora por favor\n"
                              "- No me toque por favor\n"
                              "- Llévese lo que quiera pero no me haga daño\n"
                              "- Por favor no me haga esto\n"
                              "- Por favor no me mate\n"
                              "Enviaremos una patrulla de la policía.", maxLines: 50,
                            style: TextStyle(color: Colors.black, fontSize: 15),),
                          ),
                        ]
                      )
                    )
                  )
                ),
              )
            )]
          )
        ]),
    );
  }
}