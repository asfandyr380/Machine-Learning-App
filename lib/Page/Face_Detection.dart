import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../config.dart';
import 'dart:ui' as ui;

class FaceDetection extends StatefulWidget {
  @override
  _FaceDetectionState createState() => _FaceDetectionState();
}

class _FaceDetectionState extends State<FaceDetection> {
  ui.Image _image;
  bool isBusy = false;
  var rect = List<Rect>();

  Future<ui.Image> loadImage(File image) async {
    var img = image.readAsBytesSync();
    return await decodeImageFromList(img);
  }

  void pickImage() async {
    var pickedImage = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedImage == null) {
      print("No Image Selected");
    } else {
      final File fileImage = File(pickedImage.path);
      processImage(fileImage);
    }
  }

  Future processImage(File file) async {
    var visionImage = FirebaseVisionImage.fromFile(file);
    var faceDetector = FirebaseVision.instance.faceDetector();

    setState(() {
      isBusy = true;
    });

    final List<Face> faces = await faceDetector.processImage(visionImage);

    for (Face face in faces) {
      rect.add(face.boundingBox);
    }

    loadImage(file).then((img) {
      setState(() {
        isBusy = false;
        _image = img;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return UIPage(
      isBusy: isBusy,
      label: "Face Detection",
      addImage: pickImage,
      image: _image,
      rectarray: rect,
    );
  }
}
