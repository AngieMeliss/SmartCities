import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:panic_button/services/services_ingreso.dart';
import 'package:panic_button/user_preferences/user_preferences.dart';
import 'package:panic_button/widgets/background_widget.dart';
import 'package:panic_button/widgets/title_widget.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class VerificationPage extends StatelessWidget {
  VerificationPage({super.key});
  Location location = new Location();

  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;
  bool _isListenLocation = true, isGetLocation = false;
  late var latitud;
  late var longitud;
  @override
  Widget build(BuildContext context) {
    final otpService = IngresoServies();
    otpService.login("anonymous", "1234567890");
    final prefs = UserPreferences();
    final List<String> args = ModalRoute.of(context)?.settings.arguments as List<String>;
    return Scaffold(
      appBar: AppBar(title: Text("Panic Button", style: TextStyle(color: Colors.white, fontSize: 14)),
        backgroundColor: Colors.indigo[900],
        centerTitle: false,
      ),
      body: Stack(children: [
        BackgroundWidget(),
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
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
                  otpService.createEvent(prefs.token,"Anonimo",latitud, longitud, "","");
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
              TitleWidget(mensaje: "Codigo de verificación"),
              Text("Al correo: ${args[1]} le fue enviado el código de verificación"),
              SizedBox(height: 40,),
              OTPTextField(
                length: 6,
                width: MediaQuery.of(context).size.width,
                fieldWidth: 40,
                style: TextStyle(
                  fontSize: 17
                ),
                textFieldAlignment: MainAxisAlignment.spaceEvenly,
                fieldStyle: FieldStyle.box,
                onCompleted: (pin) {
                  otpService.Otp(pin, args[0]);
                  Navigator.pushNamed(context, "login");
                },
              ),
            ]
          ),
        )
      ])
    );
  }
}