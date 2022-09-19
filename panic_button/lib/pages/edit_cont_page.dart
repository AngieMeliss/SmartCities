import 'package:flutter/material.dart';
import 'package:panic_button/services/services_ingreso.dart';
import 'package:panic_button/widgets/background_widget.dart';
import 'package:panic_button/widgets/text_field_widget.dart';

class EditContPage extends StatelessWidget {
  EditContPage({super.key});
  final TextEditingController oldEmailController = TextEditingController();
  final TextEditingController oldPhoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNaController = TextEditingController();
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        child: Text("Para editar un contacto", style: TextStyle(color: Colors.black, fontSize: 20),),
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
                    TextFieldWidget(control: oldEmailController, texto: "Correo Antiguo"),
                    TextFieldWidget(control: oldPhoneController, texto: "Teléfono Antiguo"),
                  ],)
                ),
              ),
            ),
          ),
          Divider(color: Colors.deepOrangeAccent[700],),
          Card(
              elevation: 50,
              shadowColor: Colors.black,
              color: Colors.greenAccent[100],
              child: SizedBox(
                width: 380,
                height: 30,
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(),
                        child: Text("Ingresa los nuevos datos", style: TextStyle(color: Colors.black, fontSize: 20),),
                      ),
                    ],
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
              height: 290,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(),
                  child: Column(children: [
                    TextFieldWidget(control: nameController, texto: "Nombre"),
                    TextFieldWidget(control: lastNaController, texto: "Apellido"),
                    TextFieldWidget(control: emailController, texto: "Correo electrónico"),
                    TextFieldWidget(control: phoneController, texto: "Teléfono celular"),
                  ],)
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              ingServices.editContact(args[0], oldEmailController.text, oldPhoneController.text,
              nameController.text, lastNaController.text, emailController.text, phoneController.text);
              Navigator.pushNamed(context, "contacts");
            },
            child: Text('Actualizar datos'),
            style: ElevatedButton.styleFrom(
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(12)
              ),
            ),
          )
      ]),
    ],)
    );
  }
}