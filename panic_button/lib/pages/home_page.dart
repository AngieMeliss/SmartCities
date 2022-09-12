import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:panic_button/services/services_ingreso.dart';
import 'package:panic_button/widgets/background_widget.dart';
import 'package:panic_button/widgets/menu_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
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
      drawer: NavBar(),
      appBar: AppBar(title: Text("Panic Button", style: TextStyle(color: Colors.black12),),
        backgroundColor: Colors.amber[100],
        centerTitle: true,),
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
        BackgroundWidget(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Image(
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
              ],
            )
          ],
        )
      ],)
    );
  }
}