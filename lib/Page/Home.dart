import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:machin_learning_app/Page/Qr_Code.dart';
import 'package:machin_learning_app/Page/Speech_to_Text.dart';
import 'package:machin_learning_app/Page/Text_Recognization.dart';
import 'package:machin_learning_app/Page/Object_Detection.dart';
import '../config.dart';
import 'Face_Detection.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  bool isAnimated = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        isAnimated = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
            Flexible(
              child: Container(
                margin: EdgeInsets.only(top: 40, left: 20, right: 20),
                child: AnimatedDefaultTextStyle(
                  curve: Curves.elasticOut,
                  duration: Duration(seconds: 3),
                  style: isAnimated
                      ? TextStyle(
                          color: textandButton,
                          fontSize: 32,
                          fontFamily: "Schyler")
                      : TextStyle(
                          color: textandButton,
                          fontSize: 16,
                        ),
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      "Welcome To Future",
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              child: Container(
                child: Text("Machine Learning App",
                    style: TextStyle(
                        color: Color(0xff3D746E),
                        fontSize: 21,
                        fontFamily: "Schyler")),
              ),
            ),
            AnimationLimiter(
              child: Column(
                children: AnimationConfiguration.toStaggeredList(
                    duration: Duration(seconds: 2),
                    childAnimationBuilder: (widget) => SlideAnimation(
                          verticalOffset: 550.0,
                          child: FadeInAnimation(child: widget),
                        ),
                    children: myChildren(context: context)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<Widget> myChildren({BuildContext context}) {
  return [
    Padding(
      padding: EdgeInsets.only(top: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomCard(
            path: "assets/face-recognition.svg",
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return FaceDetection();
              }));
            },
          ),
          CustomCard(
            path: "assets/text.svg",
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return TextRecognization();
              }));
            },
          ),
        ],
      ),
    ),
    Padding(
      padding: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomCard(
            path: "assets/magnifying-glass.svg",
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ComingSoon();
              }));
            },
          ),
          CustomCard(
            path: "assets/qr-code-scan.svg",
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return QrCode();
              }));
            },
          ),
        ],
      ),
    ),
    Padding(
      padding: EdgeInsets.only(top: 20),
      child: CustomCard(
        path: "assets/speech.svg",
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SpeechtoText();
          }));
        },
      ),
    ),
  ];
}
