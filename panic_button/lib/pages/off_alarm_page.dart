import 'package:flutter/material.dart';
import 'package:panic_button/widgets/background_widget.dart';

class OffAlarm extends StatelessWidget {
  const OffAlarm({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> args = ModalRoute.of(context)?.settings.arguments as List<String>;
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
            Row(
              children: [
                SizedBox(width: 50,),
                Container(
                  decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('exclamation.png'),
                    //fit: BoxFit.cover,
                      )
                    ),
                ),
              ],
            ),
            Divider(color: Colors.deepOrangeAccent[700],),
            Text("Alarma", style: TextStyle(color: Colors.black, fontSize: 20),),
            Text("Generada", style: TextStyle(color: Colors.black, fontSize: 25),),
            Divider(color: Colors.deepOrangeAccent[700],),
            SizedBox(height: 10,),
            Padding(
                padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: SizedBox(
                  width: 200,
                  height: 70,
                  child: ElevatedButton(
                    child: const Text("Apagar alarma", style: TextStyle(color: Colors.white, fontSize: 16),),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.greenAccent[400],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),),
                    onPressed: (){}
                  ),
                ),
              ),
            Card(
              elevation: 50,
              shadowColor: Colors.black,
              color: Colors.blueGrey[50],
              child: SizedBox(
                width: 380,
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.symmetric(),
                  child: Text("Has reportado un ${args[1]}. \n ${args[2]}.", style: TextStyle(color: Colors.black, fontSize: 15)),
                ),
              ),
            ),
        ],)
      ]),
    );
  }
}