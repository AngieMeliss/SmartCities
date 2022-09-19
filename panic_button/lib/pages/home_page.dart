import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:panic_button/services/services_ingreso.dart';
import 'package:panic_button/user_preferences/user_preferences.dart';
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
    final prefs = UserPreferences();
    final List<String> args = ModalRoute.of(context)?.settings.arguments as List<String>;
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(title: Text("Panic Button", style: TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: Colors.indigo[900],
        centerTitle: false,
      ),
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
        BackgroundWidget(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                SizedBox(width: 200,),
                RotationTransition(turns: AlwaysStoppedAnimation(15/360),
                child: Image(
                  image: AssetImage("msg.png"),
                  width: 150,)),
              ],
            ),
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
                    create.createEvent(prefs.token,args[0],latitud, longitud, "","");
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