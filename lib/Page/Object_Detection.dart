import 'package:flutter/material.dart';

import '../config.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:tflite/tflite.dart';
// import 'dart:io';
// import '../config.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:ui' as ui;

// final String label = "assets/Models/labels.txt";
// final String ssd = "assets/Models/ssd_mobilenet.tflite";

// class Object extends StatefulWidget {
//   @override
//   _ObjectState createState() => _ObjectState();
// }

// class _ObjectState extends State<Object> {
//   double _imageWidth;
//   double _imageHeight;
//   File image;
//   List _recognitions;
//   var _model = ssd;
//   @override
//   void initState() {
//     super.initState();
//     loadTfModel();
//   }

//   void loadTfModel() async {
//     Tflite.close();
//     try {
//       String res;
//       if (_model == ssd) {
//         res = await Tflite.loadModel(
//             model: "assets/Models/ssd_mobilenet.tflite",
//             labels: "assets/Models/labels.txt");
//       } else {
//         res = await Tflite.loadModel(
//             model: "assets/Models/ssd_mobilenet.tflite",
//             labels: "assets/Models/labels.txt");
//       }
//       print(res);
//     } on PlatformException {
//       print('Failed to load the model');
//     }
//   }

//   void getImageFromGallary() async {
//     var pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
//     image = File(pickedFile.path);
//     detectObject(image);
//   }

//   detectObject(File image) async {
//     var recognitions = await Tflite.detectObjectOnImage(
//         path: image.path, // required
//         model: "SSDMobileNet",
//         imageMean: 127.5,
//         imageStd: 127.5,
//         threshold: 0.4, // defaults to 0.1
//         numResultsPerClass: 10, // defaults to 5
//         asynch: true // defaults to true
//         );
//     FileImage(image)
//         .resolve(ImageConfiguration())
//         .addListener((ImageStreamListener((ImageInfo info, bool _) {
//           setState(() {
//             _imageWidth = info.image.width.toDouble();
//             _imageHeight = info.image.height.toDouble();
//           });
//         })));
//     setState(() {
//       _recognitions = recognitions;
//     });
//   }

//   List<Widget> renderBoxes(Size screen) {
//     if (_recognitions == null) return [];
//     if (_imageWidth == null || _imageHeight == null) return [];

//     double factorX = screen.width;
//     double factorY = _imageHeight / _imageHeight * screen.width;

//     Color blue = Colors.blue;

//     return _recognitions.map((re) {
//       return Container(
//         child: Positioned(
//             left: re["rect"]["x"] * factorX,
//             top: re["rect"]["y"] * factorY,
//             width: re["rect"]["w"] * factorX,
//             height: re["rect"]["h"] * factorY,
//             child: ((re["confidenceInClass"] > 0.50))
//                 ? Container(
//                     decoration: BoxDecoration(
//                         border: Border.all(
//                       color: blue,
//                       width: 3,
//                     )),
//                     child: Text(
//                       "${re["detectedClass"]} ${(re["confidenceInClass"] * 100).toStringAsFixed(0)}%",
//                       style: TextStyle(
//                         background: Paint()..color = blue,
//                         color: Colors.white,
//                         fontSize: 15,
//                       ),
//                     ),
//                   )
//                 : Container()),
//       );
//     }).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var widthS = MediaQuery.of(context).size.width;
//     var heightS = MediaQuery.of(context).size.height;
//     var size = MediaQuery.of(context).size;
//     List<Widget> stackChildren = [];

//     stackChildren.add(Positioned(
//       // using ternary operator
//       child: image == null
//           ? Container(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Text("Please Select an Image"),
//                 ],
//               ),
//             )
//           : // if not null then
//           Container(child: Image.file(image)),
//     ));
//     stackChildren.addAll(renderBoxes(size));
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//           onPressed: getImageFromGallary,
//           tooltip: "Pick Image",
//           backgroundColor: textandButton,
//           child: Align(
//               child: SvgPicture.asset(
//             "assets/plus.svg",
//             height: 24,
//             width: 24,
//           ))),
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topRight,
//             end: Alignment.bottomLeft,
//             colors: [gradientStart, gradientEnd],
//           ),
//         ),
//         child: Column(
//           children: [
//             Container(
//               margin: EdgeInsetsDirectional.only(top: 40),
//               child: FittedBox(
//                 fit: BoxFit.fitWidth,
//                 child: Text(
//                   label,
//                   style: defaultStyle,
//                 ),
//               ),
//             ),
//             Container(
//               child: Stack(
//                 children: stackChildren,
//               ),
//               margin: EdgeInsets.only(top: 15),
//               width: widthS * 0.9,
//               height: heightS * 0.7,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(24),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class ComingSoon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("Under Development", style: defaultStyle)),
    );
  }
}
