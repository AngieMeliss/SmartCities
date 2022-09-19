import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
    decoration: const BoxDecoration(
    image: DecorationImage(
      image: AssetImage('whiteBackground.jpg'),
      fit: BoxFit.cover,
        )
      ),
    );
  }
}