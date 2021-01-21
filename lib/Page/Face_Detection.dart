import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:machin_learning_app/Services/Image_Picker.dart';
import '../config.dart';
import 'dart:ui' as ui;
import 'Widgets/Scaffold.dart';

class FaceDetection extends StatefulWidget {
  @override
  _FaceDetectionState createState() => _FaceDetectionState();
}

class _FaceDetectionState extends State<FaceDetection> {
  ui.Image _image;
  bool isBusy = false;
  File fileImage;
  var rect = List<Rect>();

  // Convert Selected File to Image
  Future<ui.Image> loadImage(File image) async {
    var img = image.readAsBytesSync();
    return await decodeImageFromList(img);
  }

  void getImage() {

    pickImage().then((value)  {
      if(value != null)
      {
        fileImage = value;
        processImage(fileImage);
      }else {
        print("No Image Selected");
      }
    });
  }

  // Processing Image for Face Detection
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
      addImage: getImage,
      image: _image,
      rectarray: rect,
    );
  }
}

// CustomPainter Class to Draw Rectangle On Faces
class Painter extends CustomPainter {
  final List<Rect> rect;
  ui.Image image;

  Painter(this.rect, this.image);
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7;

    if (image != null) {
      canvas.drawImage(image, Offset.zero, paint);
    }
    for (var i = 0; i <= rect.length - 1; i++) {
      canvas.drawRect(rect[i], paint);
    }
  }

  @override
  bool shouldRepaint(oldDelegate) {
    return true;
  }
}

class UIPage extends StatelessWidget {
  final String label;
  final String iconPath;
  final Function addImage;
  final double width;
  final double height;
  bool isBusy;
  ui.Image image;
  final List<Rect> rectarray;
  UIPage(
      {this.label,
      this.addImage,
      this.height,
      this.width,
      this.iconPath,
      this.image,
      this.rectarray,
      this.isBusy});

  @override
  Widget build(BuildContext context) {
    var widthS = MediaQuery.of(context).size.width;
    var heightS = MediaQuery.of(context).size.height;
    return DefaultScaffold(
      iconPath: iconPath,
      onClick: addImage,
      childWidget: Column(
        children: [
          Container(
            margin: EdgeInsetsDirectional.only(top: 40),
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                label,
                style: defaultStyle,
              ),
            ),
          ),
          Container(
            child: Center(
              child: isBusy
                  ? Center(child: CircularProgressIndicator())
                  : FittedBox(
                      fit: BoxFit.fill,
                      child: SizedBox(
                        height: image == null
                            ? widthS * 0.9
                            : image.height.toDouble(),
                        width: image == null
                            ? heightS * 0.7
                            : image.width.toDouble(),
                        child: CustomPaint(
                          painter: Painter(rectarray, image),
                        ),
                      ),
                    ),
            ),
            margin: EdgeInsets.only(top: 15),
            width: width == null ? widthS * 0.9 : width,
            height: height == null ? heightS * 0.7 : height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
          ),
        ],
      ),
    );
  }
}
