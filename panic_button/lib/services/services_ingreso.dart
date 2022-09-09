import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:panic_button/user_preferences/user_preferences.dart';

class IngresoServies {
  final prefs = UserPreferences();
  final ip = "http://sistemic.udea.edu.co:4000";

  Future login(String user, String passW) async {
    var headers = {
      'Authorization': 'Basic Zmx1dHRlci1yZXRvOnVkZWE=',
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var request = http.Request('POST', Uri.parse('$ip/reto/autenticacion/oauth/token'));
    request.bodyFields = {
      'username': user,
      'password': passW,
      'grant_type': 'password'
    };
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      final Map<String, dynamic> decodedData = json.decode(await response.stream.bytesToString());
      if (response.statusCode == 200) {
        prefs.token = decodedData["access_token"];
        print(prefs.token);
        print("Si entro");
      }
      else {
        print(response.reasonPhrase);
        print("No entro por falla de credenciales");
      }
    } catch (e) {
        print(e);
        print("No entro por falla del server");
    }
  }

  Future register(String username, String pass, String email) async {
    bool regSucces = false;
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('$ip/reto/usuarios/registro/enviar'));
    request.body = json.encode({
      "username": username,
      "password": pass,
      "email": email
    });
    request.headers.addAll(headers);
    try {
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        print("aqui");
        //regSucces = true;
      }
      else {
        print(response.reasonPhrase);
        print("aquix");
        regSucces = true;
        
      }
      
    } catch (e) {
      print("Hubo un error");
      
    }
    return regSucces;
  }

  Future Otp(String code, String username) async{
    var request = http.MultipartRequest('POST', Uri.parse('$ip/reto/usuarios/registro/confirmar/$username'));
    request.fields.addAll({
      'codigo': code
    });


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }

  }
}