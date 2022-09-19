import 'package:flutter/material.dart';
import 'package:panic_button/services/services_ingreso.dart';
import 'package:panic_button/user_preferences/user_preferences.dart';
import 'package:panic_button/widgets/appbar_widget.dart';
import 'package:panic_button/widgets/background_widget.dart';
import 'package:panic_button/widgets/camera_widget.dart';
import 'package:panic_button/widgets/text_field_widget.dart';
import 'package:location/location.dart';

class NoUrgencPage extends StatelessWidget {
  NoUrgencPage({super.key});
  Location location = new Location();

  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;
  bool _isListenLocation = true, isGetLocation = false;
  late var latitud;
  late var longitud;
  final TextEditingController evDesControl = TextEditingController();
  final TextEditingController commentControl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final create = IngresoServies();
    final prefs = UserPreferences();
    final List<String> args1 = ModalRoute.of(context)?.settings.arguments as List<String>;
    return Scaffold(
      appBar: AppBar(title: Text("Panic Button", style: TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: Colors.indigo[900],
        centerTitle: false,
      ),
      body: Stack(children: [
        BackgroundWidget(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Generar alarma...", style: TextStyle(color: Colors.black, fontSize: 20),),
            Text("Ingrese los siguientes datos", style: TextStyle(color: Colors.black, fontSize: 10),),
            SizedBox(height: 8,),
            Card(
              elevation: 50,
              shadowColor: Colors.black,
              color: Colors.greenAccent[100],
              child: SizedBox(
                width: 380,
                height: 380,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CameraWidget(),
                ),
              ),
            ),
            /*Card(
              elevation: 50,
              shadowColor: Colors.black,
              color: Colors.greenAccent[100],
              child: SizedBox(
                width: 380,
                height: 40,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(),
                    child: Text("Ubicación: [$latitud?, $longitud?]", style: TextStyle(color: Colors.black54, fontSize: 17.3),),
                  ),
                ),
              ),
            ),*/
            Card(
              elevation: 40,
              shadowColor: Colors.black,
              color: Colors.greenAccent[100],
              child: SizedBox(
                width: 380,
                height: 40,
                child: Padding(
                  padding: const EdgeInsets.symmetric(),
                  child: TextFieldWidget(control: evDesControl, texto: "Descripción del evento"),
                ),
              ),
            ),
            Card(
              elevation: 50,
              shadowColor: Colors.black,
              color: Colors.greenAccent[100],
              child: SizedBox(
                width: 380,
                height: 40,
                child: Padding(
                  padding: const EdgeInsets.symmetric(),
                  child: TextFieldWidget(control: commentControl, texto: "Comentarios"),
                ),
              ),
            ),
            Padding(
              padding:
                const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 11, 3, 121)),
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
                    create.createEvent(prefs.token,args1[0], latitud, longitud, evDesControl.text, commentControl.text);
                    //print([latitud, longitud]);
                    Navigator.pushNamed(context, "offAlarm", arguments: [args1[0], args1[1], args1[2]]);
                  },
                  child: const Text("Generar alarma", style: TextStyle(color: Colors.white),)
                  )
              ),
            ),
            StreamBuilder(
              stream: location.onLocationChanged,
              builder: (context, snapshot) {
                if(snapshot.connectionState != ConnectionState.waiting){
                  var data = snapshot.data as LocationData;
                  latitud = data.latitude!;
                  longitud = data.longitude!;
                  return Text("");
                }
                else return Center(child: CircularProgressIndicator(),);
              }),
          ],
        ),
      ]),
    );
  }
}