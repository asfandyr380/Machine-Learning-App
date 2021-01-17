import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:ui' as ui;

Color gradientStart = Color(0xff81D57B);
Color gradientEnd = Color(0xff68A7A7);
Color textandButton = Color(0xff1B4843);

TextStyle defaultStyle =
    TextStyle(color: textandButton, fontSize: 29, fontFamily: 'Schyler');

class DefaultScaffold extends StatelessWidget {
  final Function onClick;
  final String iconPath;
  final Widget childWidget;

  DefaultScaffold({this.iconPath, this.onClick, this.childWidget});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: onClick,
          tooltip: "Pick Image",
          backgroundColor: textandButton,
          child: Align(
              child: SvgPicture.asset(
            iconPath == null ? "assets/plus.svg" : iconPath,
            height: 24,
            width: 24,
          ))),
      body: Container(
        child: childWidget,
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [gradientStart, gradientEnd],
          ),
        ),
      ),
    );
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

class Painter extends CustomPainter {
  final List<Rect> rect;
  ui.Image image;

  Painter(@required this.rect, @required this.image);
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

class CustomCard extends StatelessWidget {
  final String path;
  final Function onTap;
  CustomCard({this.path, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        width: 151,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Color(0xff1B4558), width: 1.8),
        ),
        child: Align(
          alignment: Alignment.center,
          child: SvgPicture.asset(
            path,
            height: 82,
            width: 82,
          ),
        ),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final bool isPlayButton;
  final Function onTap;
  final String svgPath;
  final String tag;
  ActionButton({this.onTap, this.isPlayButton, this.svgPath, this.tag});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isPlayButton ? 70 : 50,
      width: isPlayButton ? 70 : 50,
      margin: EdgeInsets.only(top: isPlayButton ? 60 : 170),
      child: FittedBox(
        child: FloatingActionButton(
          heroTag: tag,
          onPressed: onTap,
          elevation: 5,
          backgroundColor: textandButton,
          child: Align(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              svgPath,
              width: 24,
              height: 24,
            ),
          ),
        ),
      ),
    );
  }
}
