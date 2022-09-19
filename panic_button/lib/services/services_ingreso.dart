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
    } catch (error) {
        print("No entro por falla del server");
        print(error);
    }
  }

  Future register(String username, String pass, String email) async {
    final regSucces;
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
      }
      else {
        print(response.reasonPhrase);
      }
      
    } catch (error) {
      print("Hubo un error");
      print(error);
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
  Future createEvent(String tok, String userName, var latitud, var longitud, String evDesc, String comment) async {
    var headers = {
    'Authorization': 'Bearer $tok',
    'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('$ip/reto/events/eventos/crear/usuario/$userName'));
    request.body = json.encode({
      "location": [latitud, longitud],
      "eventDescription": evDesc,
      "comment": comment
    });
    request.headers.addAll(headers);
    try {
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      }
      else {
        print(response.reasonPhrase);
      }
    } catch (error) {
      print("Algo salió mal");
      print(error);
    }
  }

  Future addContact (String userName, String name, String lastname, String email, String phone) async {
    var headers = {
      'Authorization': 'Bearer ${prefs.token}',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('$ip/reto/usuarios/contactos/crear/$userName'));
    request.body = json.encode({
      "name": name,
      "lastName": lastname,
      "email": email,
      "cellPhone": phone
    });
    request.headers.addAll(headers);
    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      }
      else {
        print(response.reasonPhrase);
      }
    } catch (error) {
      print("Algo salió mal");
      print(error);
    }
  }

  Future editContact(String userName, String oldEmail, String oldPhone,
    String name, String lastname, String newEmail, String newPhone) async {
    var headers = {
      'Authorization': 'Bearer ${prefs.token}',
      'Content-Type': 'application/json'
    };
    var request = http.Request('PUT', Uri.parse('$ip/reto/usuarios/contactos/editar/$userName/email/$oldEmail/cellPhone/$oldPhone'));
    request.body = json.encode({
      "name": name,
      "lastName": lastname,
      "email": newEmail,
      "cellPhone": newPhone,
    });
    request.headers.addAll(headers);
    try {
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      }
      else {
        print(response.reasonPhrase);
      }
    } catch (error) {
      print("Algo salió mal");
      print(error);
    }
  }

  Future deleteContact(String userName, String email, String phone) async {
    var headers = {
      'Authorization': 'Bearer ${prefs.token}'
    };
    var request = http.Request('DELETE', Uri.parse('$ip/reto/usuarios/contactos/eliminar/$userName/email/$email/cellPhone/$phone'));

    request.headers.addAll(headers);
    try {
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      }
      else {
        print(response.reasonPhrase);
      }
    } catch (error) {
      print("Algo salió mal");
      print(error);
    }

  }
}
