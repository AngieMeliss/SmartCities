import 'package:flutter/material.dart';
import 'package:panic_button/widgets/background_widget.dart';
import 'package:panic_button/widgets/redbutton_widget.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Stack(children: [
        BackgroundWidget(),
        RedButtonWidget(),
      ],)
    );
  }
}