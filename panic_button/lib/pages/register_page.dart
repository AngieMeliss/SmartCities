import 'package:flutter/material.dart';
import 'package:panic_button/services/services_ingreso.dart';
import 'package:panic_button/widgets/background_widget.dart';
import 'package:panic_button/widgets/redbutton_widget.dart';
import 'package:panic_button/widgets/text_field_widget.dart';
import 'package:panic_button/widgets/title_widget.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final regService = IngresoServies();
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
              TitleWidget(mensaje: "Registro"),
              SizedBox(height: 40,),
              RedButtonWidget(),
              TextFieldWidget(control: userController, texto: "UserName",),
              TextFieldWidget(control: passController, texto: "PassWord",),
              TextFieldWidget(control: emailController, texto: "Email",),
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
                          regService.register(userController.text, passController.text, emailController.text);
                          Navigator.pushNamed(context, "otp", arguments: [
                            userController.text, 
                            emailController.text]);
                        },
                        child: const Text("Registrarse", style: TextStyle(color: Colors.white),))),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Ya tienes cuenta?"),
                  TextButton(
                      onPressed: () {Navigator.pushNamed(context, "login");},
                      child: const Text(
                        "Inicio de sesión",
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