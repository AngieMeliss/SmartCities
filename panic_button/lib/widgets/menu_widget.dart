import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> args = ModalRoute.of(context)?.settings.arguments as List<String>;
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(args[0]),
            accountEmail: Text('  '),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset("profilePhoto.png",
                  fit: BoxFit.fill,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("profileBackground.jpg")),
            ),
          ),
          Card(
            elevation: 50,
            shadowColor: Colors.black,
            color: Colors.greenAccent[100],
            child: SizedBox(
              width: 310,
              height: 380,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(children: [
                  Text("Quiero reportar...", style: TextStyle(color: Colors.black, fontSize: 20),),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.car_crash),
                    title: Text('Accidente de Transito'),
                    onTap: () {
                      Navigator.pushNamed(context, "nourgente", arguments: [args[0], "Accidente de transito",
                      "Una ambulancia llegará en 5 minutos"]);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.fireplace_outlined),
                    title: Text('Incendio'),
                    onTap: () {
                      Navigator.pushNamed(context, "nourgente", arguments: [args[0], "Incendio",
                      "Los bomberos llegarán en 7 minutos"]);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.storm_outlined),
                    title: Text('Robo-Hurto'),
                    onTap: () {
                      Navigator.pushNamed(context, "nourgente", arguments: [args[0], "Robo-Hurto",
                      "Una patrulla llegará en 5 minutos"]);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.back_hand_rounded),
                    title: Text('Violación/Acoso sexual'),
                    onTap: () {
                      Navigator.pushNamed(context, "nourgente", arguments: [args[0], "Violación/Acoso sexual",
                      "Una patrulla llegará en 5 minutos"]);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Otro'),
                    onTap: () {
                      Navigator.pushNamed(context, "nourgente", arguments: [args[0], "Alarma",
                      "Estamos gestionando ayudas"]);
                    },
                  ),
                ]),
              ),
            ),
          ),
          Divider(),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, "contacts", arguments: [args[0]]);
            },
            child: const Text(
              "Contactos",
              style: TextStyle(
                  color: Color.fromARGB(255, 45, 13, 226),
                  fontSize: 15,
                  fontWeight: FontWeight.w600
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, "training");
            },
            child: const Text(
              "Capacitación",
              style: TextStyle(
                  color: Color.fromARGB(255, 45, 13, 226),
                  fontSize: 15,
                  fontWeight: FontWeight.w600
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, "welcome");
            },
            child: const Text(
              "Cerrar sesión",
              style: TextStyle(
                  color: Color.fromARGB(255, 45, 13, 226),
                  fontSize: 15,
                  fontWeight: FontWeight.w600
              ),
            ),
          ),
        ],
      ),
    );
  }
}