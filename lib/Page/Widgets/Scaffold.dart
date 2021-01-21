import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../config.dart';

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
