import 'package:flutter/material.dart';
import 'package:panic_button/services/services_ingreso.dart';
import 'package:panic_button/widgets/background_widget.dart';
import 'package:panic_button/widgets/title_widget.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class VerificationPage extends StatelessWidget {
  const VerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final otpService = IngresoServies();
    final List<String> args = ModalRoute.of(context)?.settings.arguments as List<String>;
    return Scaffold(
      body: Stack(children: [
        BackgroundWidget(),
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TitleWidget(mensaje: "Codigo de verificación"),
              Text("Al correo: ${args[1]} le fue enviado el código de verificación"),
              SizedBox(height: 40,),
              OTPTextField(
                length: 6,
                width: MediaQuery.of(context).size.width,
                fieldWidth: 40,
                style: TextStyle(
                  fontSize: 17
                ),
                textFieldAlignment: MainAxisAlignment.spaceEvenly,
                fieldStyle: FieldStyle.box,
                onCompleted: (pin) {
                  otpService.Otp(pin, args[0]);
                  Navigator.pushNamed(context, "login");
                },
              ),
            ]
          ),
        )
      ])
    );
  }
}