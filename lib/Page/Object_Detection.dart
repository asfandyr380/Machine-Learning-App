import 'package:flutter/material.dart';

import '../config.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tflite/tflite.dart';
import 'dart:io';
import '../config.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:ui' as ui;

const String ssd = 'SSD MobileNet';

class Object extends StatefulWidget {
  @override
  _ObjectState createState() => _ObjectState();
}

class _ObjectState extends State<Object> {
  double _imageWidth;
  double _imageHeight;
  File _image;
  bool _busy = false;
  List _recognitions;
  @override
  void initState() {
    super.initState();
    loadTfModel();
  }

  void loadTfModel() async {
    Tflite.close();
    try {
      await Tflite.loadModel(
          model: "assets/Models/ssd_mobilenet.tflite",
          labels: "assets/Models/labels.txt");
    } on PlatformException {
      print("faild to Load Models");
    }
  }

  void getImageFromGallary() async {
    var pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile == null) return;
    _image = File(pickedFile.path);
    setState(() {
      _busy = true;
    });
    detectObject(_image);
  }

  detectObject(File image) async {
    if (image == null) return;
    ssdMobileNet(image);

    FileImage(image)
        .resolve(ImageConfiguration())
        .addListener((ImageStreamListener((ImageInfo info, bool _) {
          setState(() {
            _imageWidth = info.image.width.toDouble();
            _imageHeight = info.image.height.toDouble();
          });
        })));

    setState(() {
      _image = image;
      _busy = false;
    });
  }

  ssdMobileNet(File image) async {
    var recognitions = await Tflite.detectObjectOnImage(
        path: image.path, numResultsPerClass: 1);

    setState(() {
      _recognitions = recognitions;
    });
  }

  List<Widget> renderBoxes(Size screen) {
    if (_recognitions == null) return [];
    if (_imageWidth == null || _imageHeight == null) return [];

    double factorX = screen.width;
    double factorY = _imageWidth / _imageHeight * screen.width;

    return _recognitions.map((re) {
      return Positioned(
        left: re["rect"]["x"] * factorX,
        top: re["rect"]["y"] * factorY,
        width: re["rect"]["w"] * factorX,
        height: re["rect"]["h"] * factorY,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
            color: Colors.blue,
            width: 3,
          )),
          child: Text(
            "${re["detectedClass"]} ${(re["confidenceInClass"] * 100).toStringAsFixed(0)}%",
            style: TextStyle(
              background: Paint()..color = Colors.blue,
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List<Widget> stackChildren = [];

    stackChildren.add(Center(
      child: _image == null ? Text("No Image Selected") : Image.file(_image),
    ));

    stackChildren.add(
      FittedBox(
        child: Container(
          margin: EdgeInsets.only(top: 40, left: 75),
          child: Text("Object Detection", style: defaultStyle),
        ),
      ),
    );

    stackChildren.addAll(renderBoxes(size));

    if (_busy) {
      stackChildren.add(Center(
        child: CircularProgressIndicator(),
      ));
    }

    return DefaultScaffold(
      onClick: getImageFromGallary,
      childWidget: Stack(
        children: stackChildren,
      ),
    );
  }
}
