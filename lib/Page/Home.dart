import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:machin_learning_app/Page/Qr_Code.dart';
import 'package:machin_learning_app/Page/Speech_to_Text.dart';
import 'package:machin_learning_app/Page/Text_Recognization.dart';
import 'package:machin_learning_app/Page/Object_Detection.dart';
import '../config.dart';
import 'Face_Detection.dart';
import 'Widgets/CustomCard.dart';

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
                      ? defaultStyle.copyWith(fontSize: 32)
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
                child: Text(
                  "Machine Learning App",
                  style: defaultStyle.copyWith(
                    fontSize: 21,
                    color: Color(0xff3D746E),
                  ),
                ),
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
      child: cardRow(
        path1: "assets/face-recognition.svg",
        path2: "assets/text.svg",
        ctx: context,
        returnType2: TextRecognization(),
        returnType1: FaceDetection(),
      ),
    ),
    Padding(
      padding: EdgeInsets.only(top: 20),
      child: cardRow(
        ctx: context,
        path1: "assets/magnifying-glass.svg",
        path2: "assets/qr-code-scan.svg",
        returnType1: Object(),
        returnType2: QrCode(),
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
