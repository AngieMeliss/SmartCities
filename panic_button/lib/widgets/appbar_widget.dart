import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(title: Text("Panic Button", style: TextStyle(color: Colors.white, fontSize: 14)),
        backgroundColor: Colors.indigo[900],
        centerTitle: false,
    );
  }
}