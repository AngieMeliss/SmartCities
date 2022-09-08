import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({super.key, required this.control, required this.texto});

  final TextEditingController control;
  final String texto;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: TextField(
        controller: control,
        decoration: InputDecoration(
          border: const OutlineInputBorder(), labelText: texto),
      ),
    );
  }
}