import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:machin_learning_app/Page/Widgets/Scaffold.dart';
import 'package:machin_learning_app/Services/Image_Picker.dart';
import 'dart:io';
import '../config.dart';

class TextRecognization extends StatefulWidget {
  @override
  _TextRecognizationState createState() => _TextRecognizationState();
}

class _TextRecognizationState extends State<TextRecognization> {
  String text = "";
  File file;
  bool isBusy = false;

  void getImage() async {
    pickImage().then((value) {
      if (value != null) {
        file = value;
        processImage(file).then((value) {
          setState(() {
            text = value;
            isBusy = false;
          });
        });
      }else print("No Image Selected");
    });
  }

  // Processing Image to recognize Text
  Future<String> processImage(File file) async {
    var visionImage = FirebaseVisionImage.fromFile(file);
    var textRecognizer = FirebaseVision.instance.textRecognizer();

    setState(() {
      isBusy = true;
    });

    final VisionText processedText =
        await textRecognizer.processImage(visionImage);

    // Formating Processed Text from Image
    for (TextBlock block in processedText.blocks) {
      for (TextLine line in block.lines) {
        text = text + '\n';
        for (TextElement word in line.elements) {
          text = text + word.text;
        }
      }
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    var widthS = MediaQuery.of(context).size.width;
    var heightS = MediaQuery.of(context).size.height;
    return DefaultScaffold(
      onClick: () {
        setState(() {
          text = "";
        });
        getImage();
      },
      childWidget: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [gradientStart, gradientEnd],
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 40),
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  "Text Recognization",
                  style: defaultStyle,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Center(
                child: isBusy
                    ? CircularProgressIndicator()
                    : FittedBox(
                        fit: BoxFit.contain,
                        child: file == null ? null : Image.file(file),
                      ),
              ),
              width: widthS * 0.9,
              height: heightS * 0.4,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 10),
                child: Align(
                    child: SvgPicture.asset(
                  "assets/down-arrow.svg",
                  width: 32,
                  height: 32,
                ))),
            InteractiveViewer(
              child: Container(
                child: isBusy
                    ? Center(child: CircularProgressIndicator())
                    : Center(
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: SelectableText(
                            text,
                            style: defaultStyle,
                          ),
                        ),
                      ),
                margin: EdgeInsets.only(top: 10),
                width: widthS * 0.6,
                height: heightS * 0.22,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
