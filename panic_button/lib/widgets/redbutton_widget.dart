import 'package:flutter/material.dart';
class RedButtonWidget extends StatelessWidget {
  const RedButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: 
        Stack(children: [
          Center(child:
            Image(
              image: AssetImage("flashLight.png"),
              width: 250,
            ),
          ),
          Center(child:
            Image( // Hay que cambiarlo por un boton
              image: AssetImage("redButton.png"),
              width: 180,
            ),
          ),
        ],),
    );
  }
}