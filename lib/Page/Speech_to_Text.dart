import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_recognition_error.dart';

import '../config.dart';

class SpeechtoText extends StatefulWidget {
  @override
  _SpeechtoTextState createState() => _SpeechtoTextState();
}

class _SpeechtoTextState extends State<SpeechtoText> {

  bool _hasSpeech = false;
  bool isListening = false;
  String lastWords = "";
  String lastError = "";
  String lastStatus = "";
  final SpeechToText speech = SpeechToText();

  @override
  void initState() {
    super.initState();
    initSpeechState();
  }

  Future<void> initSpeechState() async {
    bool hasSpeech = await speech.initialize(
        onError: errorListener, onStatus: statusListener);

    if (!mounted) return;
    setState(() {
      _hasSpeech = hasSpeech;
    });
  }

   void startListening() {
    lastWords = "";
    lastError = "";
    speech.listen(onResult: resultListener);
    setState(() {
      isListening = true;
    });
  }

  void stopListening() {
    speech.stop();
    setState(() {
      isListening = false;
    });
  }

  void cancelListening() {
    speech.cancel();
    setState(() {
      isListening = false;
    });
  }

  void resultListener(SpeechRecognitionResult result) {
    setState(() {
      lastWords = "${result.recognizedWords}";
    });
  }

  void errorListener(SpeechRecognitionError error) {
    setState(() {
      lastError = "${error.errorMsg} - ${error.permanent}";
    });
  }

  void statusListener(String status) {
    setState(() {
      lastStatus = "$status";
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
            Container(
              margin: EdgeInsets.only(top: 40),
                child: Text(
              "Speech To Text",
              style: defaultStyle,
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ActionButton(
                  onTap: cancelListening,
                  tag: "cancel",
                  svgPath: "assets/cancel.svg",
                  isPlayButton: false,
                ),
                ActionButton(
                  onTap: startListening,
                  tag: "play",
                  svgPath: "assets/play.svg",
                  isPlayButton: true,
                ),
                ActionButton(
                  onTap: stopListening,
                  tag: "pause",
                  svgPath: "assets/pause.svg",
                  isPlayButton: false,
                ),
              ],
            ),
            Container(margin: EdgeInsets.only(top: 20),
              child: AnimatedDefaultTextStyle(
                curve: Curves.bounceOut,
                duration: Duration(milliseconds: 500),
                child: isListening ? Text("Lisining..."): Text(''),
                style: defaultStyle.copyWith(fontSize: 20) ,
              ),
            ),
             Container(margin: EdgeInsets.only(top: 200),
              child: Text(lastWords, style: defaultStyle.copyWith(fontSize: 17), ),
            ),
          ],
        ),
      ),
    );
  }
}
