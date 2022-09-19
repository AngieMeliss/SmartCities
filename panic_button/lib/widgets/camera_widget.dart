import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CameraWidget extends StatefulWidget {
  const CameraWidget({super.key});

  @override
  State<CameraWidget> createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  /*@override
  Widget build(BuildContext context) {
    return Container();
  }*/
  File? image;
  final ImagePicker _imagePicker = ImagePicker();
  Future selectImage(option) async {
    XFile? pickedFile;
    if (option == 1) {
      pickedFile = await _imagePicker.pickImage(source: ImageSource.camera);
    } else {
      pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        Fluttertoast.showToast(msg: "Imagen no selecionada");
      }
    });
    //Navigator.of(context).pop();
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return _buidScaffold(context);
  }

  Widget _buidScaffold(BuildContext context) {
    return ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(1),
            child: Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                _getOptions(),
                const SizedBox(
                  height: 5,
                ),
                _showImage(),
              ],
            ),
          )
        ],
      );
  }

  Widget _getOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        GestureDetector(
          onTap: () => {selectImage(1)},
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            color: Colors.black,
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 10,
              ),
              child: Column(children: const [
                Icon(
                  Icons.camera_alt,
                  color: Colors.redAccent,
                  size: 20,
                ),
                Text(
                  "Cámara",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  textScaleFactor: 0.5,
                ),
              ]),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => {selectImage(2)},
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            color: Colors.black,
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 10,
              ),
              child: Column(children: const [
                Icon(
                  Icons.image,
                  color: Colors.redAccent,
                  size: 20,
                ),
                Text(
                  "Galeria",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  textScaleFactor: 0.5,
                ),
              ]),
            ),
          ),
        ),
      ],
    );
  }

  Widget _showImage() {
    Widget imgOut = const Center();
    if (image != null) {
      imgOut = Center(
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          color: Colors.white,
          elevation: 10,
          child: Column(
            //mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AspectRatio(
                    aspectRatio: 18.0 / 13.0,
                    child: !kIsWeb
                      ? Image.file(image!, fit: BoxFit.fill)
                      : Image.network(image!.path)),
              ),
              Center(
                child: ButtonBar(
                  children: <Widget>[
                    loading
                        ? const Center(child: CircularProgressIndicator())
                        : const Center(),
                    TextButton(
                      child: Column(
                        children: const [Icon(Icons.upload), Text("Enviar")],
                      ),
                      onPressed: () {
                        setState(() {
                          loading = true;
                        });

                        ///_sendImage(image!);
                      },
                    ),
                    Column(
                      children: [
                        TextButton(
                          child: Column(
                            children: const [
                              Icon(Icons.cancel),
                              Text("Cancelar")
                            ],
                          ),
                          onPressed: () {
                            image = null;
                            loading = false;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
    return imgOut;
  }
}