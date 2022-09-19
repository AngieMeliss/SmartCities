import 'package:flutter/material.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> args = ModalRoute.of(context)?.settings.arguments as List<String>;
    return Scaffold(
      appBar: AppBar(title: Text("Panic Button", style: TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: Colors.indigo[900],
        centerTitle: false,
      ),
      body: 
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
              elevation: 50,
              shadowColor: Colors.black,
              color: Colors.greenAccent[100],
              child: SizedBox(
                width: 380,
                height: 100,
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(),
                        child: Text("En esta sección podrás configurar tus contactos, a los cuales se les enviará tu información cuando se genere un evento", 
                        style: TextStyle(color: Colors.black, fontSize: 20),),
                      ),
                    ]
                  )
                )
              )
            ),
          Padding(
            padding:
              const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 24, 192, 75)),
                onPressed: () {
                  Navigator.pushNamed(context, "addContact", arguments: [args[0]]);
                },
                child: const Text("Agregar contacto", style: TextStyle(color: Colors.white),))),
          ),
          Padding(
            padding:
              const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueAccent[400]),
                onPressed: () {
                  Navigator.pushNamed(context, "editContact", arguments: [args[0]]);
                },
                child: const Text("Editar contacto", style: TextStyle(color: Colors.white),))),
          ),
          Padding(
            padding:
              const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red[400]),
                onPressed: () {
                  Navigator.pushNamed(context, "deleteContact", arguments: [args[0]]);
                },
                child: const Text("Eliminar contacto", style: TextStyle(color: Colors.white),))),
          ),
        ],
      ),
    );
  }
}