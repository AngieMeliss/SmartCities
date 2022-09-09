import 'package:flutter/material.dart';
import 'package:panic_button/pages/login_page.dart';
import 'package:panic_button/pages/register_page.dart';
import 'package:panic_button/pages/verification_page.dart';
import 'package:panic_button/pages/welcome_page.dart';
import 'package:panic_button/user_preferences/user_preferences.dart';

Future<void> main() async {
  final prefs = UserPreferences();
  await prefs.initPrefs();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Para quitar a cinta de debug
      title: 'panicButtonApp',
      initialRoute: "login",
      routes: {
        "welcome":(context) => const WelcomePage(),
        "register":(context) => RegisterPage(),
        "otp":(context) => VerificationPage(),
        "login":(context) => LoginPage()
        //"home":(context) => const HomePage(),
        //"offAlarm":(context) => const OffAlarm(),
      },
    );
  }
}