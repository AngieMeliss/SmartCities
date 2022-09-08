import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key, required this.mensaje});

  final String mensaje;

  @override
  Widget build(BuildContext context) {
    return Text(
      mensaje,
      style: const TextStyle(
          color: Colors.blueGrey, fontSize: 30, fontWeight: FontWeight.bold),
    );
  }
}