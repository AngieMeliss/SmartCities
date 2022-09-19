import 'package:flutter/material.dart';
import 'package:panic_button/services/services_ingreso.dart';
import 'package:panic_button/widgets/background_widget.dart';
import 'package:panic_button/widgets/text_field_widget.dart';

class AddContactsPage extends StatelessWidget {
  AddContactsPage({super.key});
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Center(
            child: Card(
              elevation: 50,
              shadowColor: Colors.black,
              color: Colors.greenAccent[100],
              child: SizedBox(
                width: 380,
                height: 40,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(),
                    child: Text("Agregar Contacto", style: TextStyle(color: Colors.black, fontSize: 20),),
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
              ingServices.addContact(args[0], nameController.text, lastNaController.text, emailController.text, phoneController.text);
              Navigator.pushNamed(context, "contacts");
            },
            child: Text('  Agregar  '),
            style: ElevatedButton.styleFrom(primary: Colors.greenAccent[400],
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              ),
            ),
          )
      ]),
    ],)
    );
  }
}