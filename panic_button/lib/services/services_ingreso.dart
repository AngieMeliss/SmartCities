import 'dart:convert';

import 'package:http/http.dart' as http;

class IngresoServies {
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
      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
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
        print("Se envio el correo con el codigo");
      }
      else {
        print(response.reasonPhrase);
        print("No se envio el codigo");
      }
    } catch (e) {
      print("Hubo un error");
      
    }
    
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