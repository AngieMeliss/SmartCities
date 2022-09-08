import 'package:flutter/material.dart';
import 'package:panic_button/pages/register_page.dart';
import 'package:panic_button/services/services_ingreso.dart';
import 'package:panic_button/widgets/background_widget.dart';
import 'package:panic_button/widgets/redbutton_widget.dart';
import 'package:panic_button/widgets/text_field_widget.dart';
import 'package:panic_button/widgets/title_widget.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ingServices = IngresoServies();
    return Scaffold(
      body:
      Stack(children: [
        BackgroundWidget(),
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TitleWidget(mensaje: "Iniciar sesión"),
              RedButtonWidget(),
              TextFieldWidget(control: userController, texto: "UserName"),
              TextFieldWidget(control: passController, texto: "PassWord"),
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
                      //Agregar una condicion para cuando los campos esten vacios
                      ingServices.login(userController.text, passController.text);
                    },
                    child: const Text("Iniciar sesion", style: TextStyle(color: Colors.white),))),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("No tienes cuenta?"),
                  TextButton(
                      onPressed: () {Navigator.pushNamed(context, "register");},
                      child: const Text(
                        "Registrate",
                        style: TextStyle(
                            color: Colors.lightGreen,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                      ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],),
    );
  }
}