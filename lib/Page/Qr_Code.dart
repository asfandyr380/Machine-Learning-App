import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart';
import '../config.dart';

class QrCode extends StatefulWidget {
  @override
  _QrCodeState createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  TextEditingController _controller;
  String result = '';

  scanQr() async {
    await Permission.camera.request();
    String scanResult = await scan();
    if (scanResult == null) {
      Fluttertoast.showToast(
          msg: "Nothing was Found",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM);
    } else {
      setState(() {
        result = scanResult;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var widthS = MediaQuery.of(context).size.width;
    var heightS = MediaQuery.of(context).size.height;
    return DefaultScaffold(
        onClick: scanQr,
        childWidget: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 40),
              child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text("Qr Code Scanner", style: defaultStyle)),
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              width: widthS * 0.8,
              height: heightS * 0.2,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(24)),
              child: Center(
                child: FittedBox(
                  child: SelectableText(
                    result,
                    style: defaultStyle.copyWith(fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
