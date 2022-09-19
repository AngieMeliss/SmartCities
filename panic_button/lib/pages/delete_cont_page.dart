import 'package:flutter/material.dart';
import 'package:panic_button/services/services_ingreso.dart';
import 'package:panic_button/widgets/background_widget.dart';
import 'package:panic_button/widgets/text_field_widget.dart';

class DelContPage extends StatelessWidget {
  DelContPage({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final List<String> args = ModalRoute.of(context)?.settings.arguments as List<String>;
    final ingServices = IngresoServies();
    return Scaffold(
      appBar: AppBar(title: Text("Panic Button", style: TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: Colors.indigo[900],
        centerTitle: false,
      ),
      body: Stack(children: [
        BackgroundWidget(),
        Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Center(
            child: Card(
              elevation: 50,
              shadowColor: Colors.black,
              color: Colors.greenAccent[100],
              child: SizedBox(
                width: 380,
                height: 50,
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(),
                        child: Text("Para eliminar un contacto", style: TextStyle(color: Colors.black, fontSize: 20),),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(),
                        child: Text("Ingresa su correo y su teléfono", style: TextStyle(color: Colors.black, fontSize: 15),),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Card(
            elevation: 50,
            shadowColor: Colors.black,
            color: Colors.greenAccent[100],
            child: SizedBox(
              width: 380,
              height: 150,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(),
                  child: Column(children: [
                    TextFieldWidget(control: emailController, texto: "Correo"),
                    TextFieldWidget(control: phoneController, texto: "Teléfono"),
                  ],)
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              ingServices.deleteContact(args[0], emailController.text, phoneController.text);
              Navigator.pushNamed(context, "contacts");
            },
            child: Text('Eliminar contacto'),
            style: ElevatedButton.styleFrom(primary: Colors.red[800],
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(12)
              ),
            ),
          )
          ]
        ),
      ])
    );
  }
}