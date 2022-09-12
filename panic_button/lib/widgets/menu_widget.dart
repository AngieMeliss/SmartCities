import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Oflutter.com'),
            accountEmail: Text('example@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset("profilePhoto.png",
                  fit: BoxFit.cover,
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
              height: 490,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(children: [
                  ListTile(
                    leading: Icon(Icons.car_crash),
                    title: Text('Accidente de Transito'),
                    onTap: () => null,
                  ),
                  ListTile(
                    leading: Icon(Icons.fireplace_outlined),
                    title: Text('Incendio'),
                    onTap: () => null,
                  ),
                  ListTile(
                    leading: Icon(Icons.storm_outlined),
                    title: Text('Robo-Hurto'),
                    onTap: () => null,
                  ),
                  ListTile(
                    leading: Icon(Icons.back_hand_rounded),
                    title: Text('Violación/Acoso sexual'),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Otro'),
                    onTap: () => null,
                  ),
                  Divider(),
                ])
              )
            ),
          )
        ],
      ),
    );
  }
}