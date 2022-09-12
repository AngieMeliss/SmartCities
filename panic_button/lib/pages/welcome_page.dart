import 'dart:html';
import 'package:panic_button/services/services_ingreso.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:panic_button/widgets/background_widget.dart';

class WelcomePage extends StatelessWidget {
  WelcomePage({super.key});
  Location location = new Location();

  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;
  bool _isListenLocation = true, isGetLocation = false;
  late var latitud;
  late var longitud;

  @override
  Widget build(BuildContext context) {
    final create = IngresoServies();
    return Scaffold(
      body:
      Stack(
        children: [
        BackgroundWidget(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [ Image(
                image: AssetImage("flashLight.png"),
                width: 250,
              ),
              IconButton(
                icon: Image.asset("redButton.png"),
                splashRadius: 20,
                padding: const EdgeInsets.all(8),
                iconSize: 180,
                onPressed: () async {
                  _serviceEnabled = await location.serviceEnabled();
                  if (!_serviceEnabled) {
                    _serviceEnabled = await location.requestService();
                    if (!_serviceEnabled) {
                      return;
                    }
                  }
                  _permissionGranted = await location.hasPermission();
                  if (_permissionGranted == PermissionStatus.denied) {
                    _permissionGranted = await location.requestPermission();
                    if (_permissionGranted != PermissionStatus.granted) {
                      return;
                    }
                  }
                  /* setState((){
                    _isListenLocation = true;
                  }); */
                  create.createEvent("Anonimo",latitud, longitud, "","");
                  Navigator.pushNamed(context, "alarm");
                },
              ),
              StreamBuilder(
                stream: location.onLocationChanged,
                builder: (context, snapshot) {
                  if(snapshot.connectionState != ConnectionState.waiting){
                    var data = snapshot.data as LocationData;
                    latitud = data.latitude;
                    longitud = data.longitude;
                    return Text("");
                  }
                  else return Center(child: CircularProgressIndicator(),);
                }),
              ]
            ),
            Padding(
              padding:
                const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 11, 3, 121)),
                  onPressed: () {
                    Navigator.pushNamed(context, "login");
                  },
                  child: const Text("Iniciar sesion", style: TextStyle(color: Colors.white),))),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("No tienes cuenta?"),
                TextButton(
                  onPressed: () {Navigator.pushNamed(context, "register");},
                  child: const Text(
                    "Registrate",
                    style: TextStyle(
                        color: Colors.lightGreen,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        /* MaterialButton(
          onPressed: () {},
          color: Colors.blue,
          textColor: Colors.white,
          child: Icon(
            Image.asset("redButton.png"),
            size: 24,
          ),
          padding: EdgeInsets.all(16),
          shape: CircleBorder(),
        ) */
        ]
      )
    );
  }
}